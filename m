From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v6 07/10] powerpc/perf: open access for CAP_PERFMON
 privileged process
Date: Wed, 29 Jan 2020 08:17:33 +1100 (AEDT)
Message-ID: <alpine.LRH.2.21.2001290817160.2204@namei.org>
References: <74d524ab-ac11-a7b8-1052-eba10f117e09@linux.intel.com>
 <3ce8fc61-a61f-5efc-9167-94f5d39b6f1b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <3ce8fc61-a61f-5efc-9167-94f5d39b6f1b@linux.intel.com>
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

> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  arch/powerpc/perf/imc-pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index cb50a9e1fd2d..e837717492e4 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -898,7 +898,7 @@ static int thread_imc_event_init(struct perf_event *event)
>  	if (event->attr.type != event->pmu->type)
>  		return -ENOENT;
>  
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!perfmon_capable())
>  		return -EACCES;
>  
>  	/* Sampling not supported */
> @@ -1307,7 +1307,7 @@ static int trace_imc_event_init(struct perf_event *event)
>  	if (event->attr.type != event->pmu->type)
>  		return -ENOENT;
>  
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!perfmon_capable())
>  		return -EACCES;
>  
>  	/* Return if this is a couting event */
> 


Acked-by: James Morris <jamorris@linux.microsoft.com>

-- 
James Morris
<jmorris@namei.org>
