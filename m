From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v4 7/9] parisc/perf: open access for CAP_SYS_PERFMON
 privileged process
Date: Mon, 27 Jan 2020 09:52:10 +0100
Message-ID: <00d0213a-dce8-45b1-1905-11ea4af2d207@gmx.de>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <806e4881-5c22-5914-a656-5eeb65130dbe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <806e4881-5c22-5914-a656-5eeb65130dbe@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Casey Schaufler <casey@schaufler-ca.com>, Robert Richter <rric@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Igor Lubashev <ilubashe@akamai.com>, oprofile-list@lists.sf.net, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>"linux-security-module@vger.kernel.org" <lin>
List-Id: linux-perf-users.vger.kernel.org

On 18.12.19 10:29, Alexey Budankov wrote:
>
> Open access to monitoring for CAP_SYS_PERFMON privileged processes.
> For backward compatibility reasons access to the monitoring remains open
> for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for secure
> monitoring is discouraged with respect to CAP_SYS_PERFMON capability.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Acked-by: Helge Deller <deller@gmx.de>

> ---
>  arch/parisc/kernel/perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/parisc/kernel/perf.c b/arch/parisc/kernel/perf.c
> index 676683641d00..c4208d027794 100644
> --- a/arch/parisc/kernel/perf.c
> +++ b/arch/parisc/kernel/perf.c
> @@ -300,7 +300,7 @@ static ssize_t perf_write(struct file *file, const char __user *buf,
>  	else
>  		return -EFAULT;
>
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!perfmon_capable())
>  		return -EACCES;
>
>  	if (count != sizeof(uint32_t))
>
