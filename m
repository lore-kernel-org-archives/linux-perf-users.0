From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/16] tools headers uapi: Sync linux/kvm.h with the
 kernel sources
Date: Sat, 5 Jan 2019 17:04:33 +0100
Message-ID: <8acdc7e0-5597-e301-e7cd-7be1bbd09f29@redhat.com>
References: <20190104183337.12771-1-acme@kernel.org>
 <20190104183337.12771-10-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104183337.12771-10-acme@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On 04/01/19 19:33, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To get the changes from these csets:
> 
>   2bc39970e932 ("x86/kvm/hyper-v: Introduce KVM_GET_SUPPORTED_HV_CPUID")
>   2a31b9db1535 ("kvm: introduce manual dirty log reprotect")
> 
> That results in these new KVM IOCTLs being supported in 'perf trace'
> when beautifying the cmd ioctl syscall argument:
> 
>   $ cp include/uapi/linux/kvm.h tools/include/uapi/linux/kvm.h
>   $ tools/perf/trace/beauty/kvm_ioctl.sh > after
>   $ diff -u before after
>   --- before	2019-01-04 11:44:23.506605301 -0300
>   +++ after	2019-01-04 11:44:36.878730583 -0300
>   @@ -86,6 +86,8 @@
>         [0xbd] = "HYPERV_EVENTFD",
>         [0xbe] = "GET_NESTED_STATE",
>         [0xbf] = "SET_NESTED_STATE",
>   +     [0xc0] = "CLEAR_DIRTY_LOG",
>   +     [0xc1] = "GET_SUPPORTED_HV_CPUID",
>         [0xe0] = "CREATE_DEVICE",
>         [0xe1] = "SET_DEVICE_ATTR",
>         [0xe2] = "GET_DEVICE_ATTR",
>   $
> 
> At some point we should be able to do something:
> 
>   # perf trace -e ioctl(cmd == KVM_CLEAR_DIRTY_LOG)
> 
> And have just those ioctls, optionally with callchains, etc.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Link: https://lkml.kernel.org/n/tip-konm3iigl2os6ritt7d2bori@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/include/uapi/linux/kvm.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
> index 2b7a652c9fa4..6d4ea4b6c922 100644
> --- a/tools/include/uapi/linux/kvm.h
> +++ b/tools/include/uapi/linux/kvm.h
> @@ -492,6 +492,17 @@ struct kvm_dirty_log {
>  	};
>  };
>  
> +/* for KVM_CLEAR_DIRTY_LOG */
> +struct kvm_clear_dirty_log {
> +	__u32 slot;
> +	__u32 num_pages;
> +	__u64 first_page;
> +	union {
> +		void __user *dirty_bitmap; /* one bit per page */
> +		__u64 padding2;
> +	};
> +};
> +
>  /* for KVM_SET_SIGNAL_MASK */
>  struct kvm_signal_mask {
>  	__u32 len;
> @@ -975,6 +986,8 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
>  #define KVM_CAP_EXCEPTION_PAYLOAD 164
>  #define KVM_CAP_ARM_VM_IPA_SIZE 165
> +#define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
> +#define KVM_CAP_HYPERV_CPUID 167
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> @@ -1421,6 +1434,12 @@ struct kvm_enc_region {
>  #define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
>  #define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
>  
> +/* Available with KVM_CAP_MANUAL_DIRTY_LOG_PROTECT */
> +#define KVM_CLEAR_DIRTY_LOG          _IOWR(KVMIO, 0xc0, struct kvm_clear_dirty_log)
> +
> +/* Available with KVM_CAP_HYPERV_CPUID */
> +#define KVM_GET_SUPPORTED_HV_CPUID _IOWR(KVMIO, 0xc1, struct kvm_cpuid2)
> +
>  /* Secure Encrypted Virtualization command */
>  enum sev_cmd_id {
>  	/* Guest initialization commands */
> 
