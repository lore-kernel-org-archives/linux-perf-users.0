From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v6 01/10] capabilities: introduce CAP_PERFMON to kernel
 and user space
Date: Wed, 29 Jan 2020 08:16:13 +1100 (AEDT)
Message-ID: <alpine.LRH.2.21.2001290815420.2204@namei.org>
References: <74d524ab-ac11-a7b8-1052-eba10f117e09@linux.intel.com>
 <62274abc-6067-9121-9397-c9b626ca5f7a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <62274abc-6067-9121-9397-c9b626ca5f7a@linux.intel.com>
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
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  include/linux/capability.h          | 4 ++++
>  include/uapi/linux/capability.h     | 8 +++++++-
>  security/selinux/include/classmap.h | 4 ++--
>  3 files changed, 13 insertions(+), 3 deletions(-)


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
