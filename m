From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v6 09/10] drivers/perf: open access for CAP_PERFMON
 privileged process
Date: Wed, 29 Jan 2020 08:18:04 +1100 (AEDT)
Message-ID: <alpine.LRH.2.21.2001290817560.2204@namei.org>
References: <74d524ab-ac11-a7b8-1052-eba10f117e09@linux.intel.com>
 <f2877038-da53-f981-4ddb-4e6c1c27c60f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <f2877038-da53-f981-4ddb-4e6c1c27c60f@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Song Liu <songliubraving@fb.com>, Peter Zijlstra <peterz@infradead.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Alexei Starovoitov <ast@kernel.org>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Igor Lubashev <ilubashe@akamai.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net, Serge Hallyn <serge@hallyn.com>, Robert Richter <rric@kernel.org>, Will Deacon <will@kernel.org>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Stephane Eranian <eranian@goo>
List-Id: linux-perf-users.vger.kernel.org

On Tue, 28 Jan 2020, Alexey Budankov wrote:

> 
> Open access to monitoring for CAP_PERFMON privileged process.
> Providing the access under CAP_PERFMON capability singly, without the
> rest of CAP_SYS_ADMIN credentials, excludes chances to misuse the
> credentials and makes operation more secure.
> 
> CAP_PERFMON implements the principal of least privilege for performance
> monitoring and observability operations (POSIX IEEE 1003.1e 2.2.2.39 principle
> of least privilege: A security design principle that states that a process
> or program be granted only those privileges (e.g., capabilities) necessary
> to accomplish its legitimate function, and only for the time that such
> privileges are actually required)
> 
> For backward compatibility reasons access to the monitoring remains open
> for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for secure
> monitoring is discouraged with respect to CAP_PERFMON capability.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  drivers/perf/arm_spe_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


Acked-by: James Morris <jamorris@linux.microsoft.com>


> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 4e4984a55cd1..5dff81bc3324 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -274,7 +274,7 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>  	if (!attr->exclude_kernel)
>  		reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
>  
> -	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && capable(CAP_SYS_ADMIN))
> +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
>  		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
>  
>  	return reg;
> @@ -700,7 +700,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  
>  	reg = arm_spe_event_to_pmscr(event);
> -	if (!capable(CAP_SYS_ADMIN) &&
> +	if (!perfmon_capable() &&
>  	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
>  		    BIT(SYS_PMSCR_EL1_CX_SHIFT) |
>  		    BIT(SYS_PMSCR_EL1_PCT_SHIFT))))
> 

-- 
James Morris
<jmorris@namei.org>
