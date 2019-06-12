From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v1 2/5] KVM: arm/arm64: Adjust entry/exit and trap related
 tracepoints
Date: Wed, 12 Jun 2019 13:49:14 +0100
Message-ID: <977f8f8c-72b4-0287-4b1c-47a0d6f1fd6e@arm.com>
References: <1560330526-15468-1-git-send-email-yuzenghui@huawei.com>
 <1560330526-15468-3-git-send-email-yuzenghui@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560330526-15468-3-git-send-email-yuzenghui@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, christoffer.dall@arm.com, marc.zyngier@arm.com, acme@redhat.com, peterz@infradead.org, mingo@redhat.com, ganapatrao.kulkarni@cavium.com, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, wanghaibin.wang@huawei.com, xiexiangyou@huawei.com, linuxarm@huawei.com
List-Id: linux-perf-users.vger.kernel.org

Hi,

On 12/06/2019 10:08, Zenghui Yu wrote:
> Currently, we use trace_kvm_exit() to report exception type (e.g.,
> "IRQ", "TRAP") and exception class (ESR_ELx's bit[31:26]) together.

(They both caused an exit!)


> But hardware only saves the exit class to ESR_ELx on synchronous

EC is the 'Exception Class'. Exit is KVM/Linux's terminology.


> exceptions, not on asynchronous exceptions. When the guest exits
> due to external interrupts, we will get tracing output like:
> 
> 	"kvm_exit: IRQ: HSR_EC: 0x0000 (UNKNOWN), PC: 0xffff87259e30"
> 
> Obviously, "HSR_EC" here is meaningless.

I assume we do it this way so there is only one guest-exit tracepoint that catches all exits.
I don't think its a problem if user-space has to know the EC isn't set for asynchronous
exceptions, this is a property of the architecture and anything using these trace-points
is already arch specific.


> This patch splits "exit" and "trap" events by adding two tracepoints
> explicitly in handle_trap_exceptions(). Let trace_kvm_exit() report VM
> exit events, and trace_kvm_trap_exit() report VM trap events.
> 
> These tracepoints are adjusted also in preparation for supporting
> 'perf kvm stat' on arm64.

Because the existing tracepoints are ABI, I don't think we can change them.

We can add new ones if there is something that a user reasonably needs to trace, and can't
be done any other way.

What can't 'perf kvm stat' do with the existing trace points?


> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 516aead..af3c732 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -264,7 +264,10 @@ static int handle_trap_exceptions(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		exit_handle_fn exit_handler;
>  
>  		exit_handler = kvm_get_exit_handler(vcpu);
> +		trace_kvm_trap_enter(vcpu->vcpu_id,
> +				     kvm_vcpu_trap_get_class(vcpu));
>  		handled = exit_handler(vcpu, run);
> +		trace_kvm_trap_exit(vcpu->vcpu_id);
>  	}

Why are there two? Are you using this to benchmark the exit_handler()?

As we can't remove the EC from the exit event, I don't think this tells us anything new.


> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 90cedeb..9f63fd9 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -758,7 +758,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		/**************************************************************
>  		 * Enter the guest
>  		 */
> -		trace_kvm_entry(*vcpu_pc(vcpu));
> +		trace_kvm_entry(vcpu->vcpu_id, *vcpu_pc(vcpu));

Why do you need the PC? It was exported on exit.
(its mostly junk for user-space anyway, you can't infer anything from it)


Thanks,

James
