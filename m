From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2 7/7] parisc/perf: open access for CAP_SYS_PERFMON
 privileged process
Date: Mon, 16 Dec 2019 10:19:42 +0300
Message-ID: <22abd684-706c-1b3c-3858-e756217c9243@linux.intel.com>
References: <26101427-c0a3-db9f-39e9-9e5f4ddd009c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26101427-c0a3-db9f-39e9-9e5f4ddd009c@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, Alexei Starovoitov <ast@kernel.org>, james.bottomley@hansenpartnership.com, benh@kernel.crashing.org, Casey Schaufler <casey@schaufler-ca.com>, serge@hallyn.com, James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, Igor Lubashev <ilubashe@akamai.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, intel-gfx@lists.freedesktop.org, bgregg@netflix.com, Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-perf-users.vger.kernel.org


Open access to monitoring for CAP_SYS_PERFMON privileged processes.
For backward compatibility reasons access to the monitoring remains open
for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for secure
monitoring is discouraged with respect to CAP_SYS_PERFMON capability.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 arch/parisc/kernel/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/perf.c b/arch/parisc/kernel/perf.c
index 676683641d00..58e7d1444e4f 100644
--- a/arch/parisc/kernel/perf.c
+++ b/arch/parisc/kernel/perf.c
@@ -300,7 +300,7 @@ static ssize_t perf_write(struct file *file, const char __user *buf,
 	else
 		return -EFAULT;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!(capable(CAP_SYS_PERFMON) || capable(CAP_SYS_ADMIN)))
 		return -EACCES;
 
 	if (count != sizeof(uint32_t))
-- 
2.20.1
