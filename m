From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH v3 4/7] drm/i915/perf: open access for
 CAP_SYS_PERFMON privileged process
Date: Tue, 17 Dec 2019 14:38:56 +0300
Message-ID: <d71943f5-9c2d-7d08-5c45-2be1be98eb73@linux.intel.com>
References: <b175f283-d256-e37e-f447-6ba4ab4f3d3a@linux.intel.com>
 <bc5b2a0d-a185-91b6-5deb-a4b6e1dc3d3e@linux.intel.com>
 <503ad40c-d94e-df1d-1541-730c002ad3b7@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <503ad40c-d94e-df1d-1541-730c002ad3b7@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lionel Landwerlin <lionel.g.landwerlin@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: songliubraving@fb.com, Andi Kleen <ak@linux.intel.com>, Kees Cook <keescook@chromium.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, Jann Horn <jannh@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, intel-gfx@lists.freedesktop.org, Igor Lubashev <ilubashe@akamai.com>, linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Brendan Gregg <bgregg@netflix.com>
List-Id: linux-perf-users.vger.kernel.org


On 17.12.2019 12:45, Lionel Landwerlin wrote:
> On 16/12/2019 22:03, Alexey Budankov wrote:
>> Open access to i915_perf monitoring for CAP_SYS_PERFMON privileged processes.
>> For backward compatibility reasons access to i915_perf subsystem remains open
>> for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for secure
>> i915_perf monitoring is discouraged with respect to CAP_SYS_PERFMON capability.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> 
> 
> Assuming people are fine with this new cap, I like this idea of a lighter privilege for i915-perf.

Lionel, thanks for your meaningful input!
Appreciate your collaboration.

Regards,
Alexey

> 
> 
> -Lionel
> 
> 
> 
