From: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v2 1/7] capabilities: introduce CAP_SYS_PERFMON to kernel
 and user space
Date: Mon, 16 Dec 2019 09:04:04 -0500
Message-ID: <81603537-023c-9b6b-06ac-384de60dbb1d@tycho.nsa.gov>
References: <26101427-c0a3-db9f-39e9-9e5f4ddd009c@linux.intel.com>
 <9066ae10-63d6-67a1-d472-1f22826c9ae8@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9066ae10-63d6-67a1-d472-1f22826c9ae8@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, Alexei Starovoitov <ast@kernel.org>, james.bottomley@hansenpartnership.com, benh@kernel.crashing.org, Casey Schaufler <casey@schaufler-ca.com>, serge@hallyn.com, James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, Igor Lubashev <ilubashe@akamai.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, intel-gfx@lists.freedesktop.org, bgregg@netflix.com, Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-perf-users.vger.kernel.org

On 12/16/19 2:14 AM, Alexey Budankov wrote:
> 
> Introduce CAP_SYS_PERFMON capability devoted to secure system performance
> monitoring and observability operations so that CAP_SYS_PERFMON would assist
> CAP_SYS_ADMIN capability in its governing role for perf_events, i915_perf
> and other performance monitoring and observability subsystems of the kernel.
> 
> CAP_SYS_PERFMON intends to harden system security and integrity during
> system performance monitoring and observability operations by decreasing
> attack surface that is available to CAP_SYS_ADMIN privileged processes.
> 
> CAP_SYS_PERFMON intends to take over CAP_SYS_ADMIN credentials related to
> system performance monitoring and observability operations and balance amount
> of CAP_SYS_ADMIN credentials following with the recommendations provided
> in the capabilities man page [1] for CAP_SYS_ADMIN: "Note: this capability
> is overloaded; see Notes to kernel developers, below."
> 
> [1] http://man7.org/linux/man-pages/man7/capabilities.7.html
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   include/uapi/linux/capability.h     | 8 +++++++-
>   security/selinux/include/classmap.h | 4 ++--
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 240fdb9a60f6..7d1f8606c3e6 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -366,8 +366,14 @@ struct vfs_ns_cap_data {
>   
>   #define CAP_AUDIT_READ		37
>   
> +/*
> + * Allow system performance and observability privileged operations
> + * using perf_events, i915_perf and other kernel subsystems
> + */
> +
> +#define CAP_SYS_PERFMON		38
>   
> -#define CAP_LAST_CAP         CAP_AUDIT_READ
> +#define CAP_LAST_CAP         CAP_SYS_PERFMON
>   
>   #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
>   
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 7db24855e12d..bae602c623b0 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -27,9 +27,9 @@
>   	    "audit_control", "setfcap"
>   
>   #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
> -		"wake_alarm", "block_suspend", "audit_read"
> +		"wake_alarm", "block_suspend", "audit_read", "sys_perfmon"
>   
> -#if CAP_LAST_CAP > CAP_AUDIT_READ
> +#if CAP_LAST_CAP > CAP_SYS_PERFMON
>   #error New capability defined, please update COMMON_CAP2_PERMS.
>   #endif
>   
> 
