From: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v1 1/5] KVM: arm/arm64: Remove kvm_mmio_emulate tracepoint
Date: Thu, 13 Jun 2019 19:20:19 +0800
Message-ID: <5885c607-1314-ff53-38f1-9f48b1c16de4@huawei.com>
References: <1560330526-15468-1-git-send-email-yuzenghui@huawei.com>
 <1560330526-15468-2-git-send-email-yuzenghui@huawei.com>
 <e915c19a-51df-be88-ea3a-7c9a211f4518@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <e915c19a-51df-be88-ea3a-7c9a211f4518@arm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: James Morse <james.morse@arm.com>
Cc: acme@redhat.com, kvm@vger.kernel.org, marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, acme@kernel.org, linuxarm@huawei.com, linux-perf-users@vger.kernel.org, peterz@infradead.org, alexander.shishkin@linux.intel.com, mingo@redhat.com, xiexiangyou@huawei.com, ganapatrao.kulkarni@cavium.com, namhyung@kernel.org, jolsa@redhat.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
List-Id: linux-perf-users.vger.kernel.org

Hi James,

On 2019/6/12 20:48, James Morse wrote:
> Hi,
> 
> On 12/06/2019 10:08, Zenghui Yu wrote:
>> In current KVM/ARM code, no one will invoke trace_kvm_mmio_emulate().
>> Remove this TRACE_EVENT definition.
> 
> Oooer. We can't just go removing these things, they are visible to user-space.
> 
> I recall an article on this: https://lwn.net/Articles/737530/
> "Another attempt to address the tracepoint ABI problem"
> 
> I agree this is orphaned, it was added by commit 45e96ea6b369 ("KVM: ARM: Handle I/O
> aborts"), but there never was a caller.
> 
> The problem with removing it is /sys/kernel/debug/tracing/events/kvm/kvm_mmio_emulate
> disappears. Any program relying on that being present (but useless) is now broken.
Thanks for the reminder.

It turned out that I knew little about the tracepoint ABI :( .
I'm OK to just drop this patch in next version.


Thanks,
zenghui


.
