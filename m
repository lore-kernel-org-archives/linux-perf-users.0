From: Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v4 1/9] capabilities: introduce CAP_SYS_PERFMON to kernel
 and user space
Date: Mon, 13 Jan 2020 20:25:37 +0000
Message-ID: <7EBC6A81-1DA7-4D5C-972F-4D5987B12E2A@fb.com>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <e0cb2b8d-e964-bc23-bf80-58d7ac4ed6f1@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <e0cb2b8d-e964-bc23-bf80-58d7ac4ed6f1@linux.intel.com>
Content-Language: en-US
Content-ID: <05A2858D29365040812017508B06EED0@namprd15.prod.outlook.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Stephane Eranian <eranian@google.com>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Igor Lubashev <ilubashe@akamai.com>, James Morris <jmorris@namei.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>, Serge Hallyn <serge@hallyn.com>, Robert Richter <rric@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, seli
List-Id: linux-perf-users.vger.kernel.org



> On Dec 18, 2019, at 1:24 AM, Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
> 
> Introduce CAP_SYS_PERFMON capability devoted to secure system performance
> monitoring and observability operations so that CAP_SYS_PERFMON would
> assist CAP_SYS_ADMIN capability in its governing role for perf_events,
> i915_perf and other subsystems of the kernel.
> 
> CAP_SYS_PERFMON intends to harden system security and integrity during
> system performance monitoring and observability operations by decreasing
> attack surface that is available to CAP_SYS_ADMIN privileged processes.
> 
> CAP_SYS_PERFMON intends to take over CAP_SYS_ADMIN credentials related
> to system performance monitoring and observability operations and balance
> amount of CAP_SYS_ADMIN credentials in accordance with the recommendations
> provided in the man page for CAP_SYS_ADMIN [1]: "Note: this capability
> is overloaded; see Notes to kernel developers, below."
> 
> [1] https://urldefense.proofpoint.com/v2/url?u=http-3A__man7.org_linux_man-2Dpages_man7_capabilities.7.html&d=DwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=dR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=L5qCuMRrTvYhyjR1rpgE9vEv4HppVlOXDIzKzoGL30c&s=FNJpET4buKFRuqktVHQphaY1qE7IsdFpU4iYwpCn4tY&e= 
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Acked-by: Song Liu <songliubraving@fb.com>
