From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 07/10] powerpc/perf: open access for CAP_PERFMON
 privileged process
Date: Wed, 22 Jan 2020 16:32:00 +0530
Message-ID: <fc4c8680-2a0c-ff0a-fd60-3ff68370d1cc@linux.vnet.ibm.com>
References: <0548c832-7f4b-dc4c-8883-3f2b6d351a08@linux.intel.com>
 <b74a3983-8e41-aba7-c18d-b16eff6fd5e5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <b74a3983-8e41-aba7-c18d-b16eff6fd5e5@linux.intel.com>
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
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Song Liu <songliubraving@fb.com>, Peter Zijlstra <peterz@infradead.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Stephane Eranian <eranian@google.com>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Igor Lubashev <ilubashe@akamai.com>, James Morris <jmorris@namei.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net, Serge Hallyn <serge@hallyn.com>, Robert Richter <rric@kernel.org>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, intel-gfx
List-Id: linux-perf-users.vger.kernel.org


On 1/20/20 5:00 PM, Alexey Budankov wrote:
> Open access to monitoring for CAP_PERFMON privileged processes.
> For backward compatibility reasons access to the monitoring remains
> open for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage
> for secure monitoring is discouraged with respect to CAP_PERFMON
> capability. Providing the access under CAP_PERFMON capability singly,
> without the rest of CAP_SYS_ADMIN credentials, excludes chances to
> misuse the credentials and makes the operations more secure.
>
> Signed-off-by: Alexey Budankov<alexey.budankov@linux.intel.com>
> ---

Acked-by: Anju T Sudhakar<anju@linux.vnet.ibm.com>
