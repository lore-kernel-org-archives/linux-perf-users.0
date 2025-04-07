Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52CD20550F;
	Mon,  7 Apr 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041481; cv=none; b=jTfR/iz5Sad2SICVNToSEIbXEovWrRaUV5s6MLND3juauJje/Uv/UCponlqomXNJNqdUMaENt1dfHULv5ellKjnk5dAk+ODgtb9jbo6rfqojGYt94rG0K+H/rGT/wTtpfqwUPNmDuVsC5xlMdGXN6t6QrHgSSLzKeCF1lYmunNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041481; c=relaxed/simple;
	bh=Cw87UFmuA8ZmCf8B0CadMFiRTx/KBk+mEZ8BO/KHCAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ureyiVzVQ7XVrHEjGsgcZEoSjGEnfhMB4v975TckezZnUoXR5ZWL7eF+KRvdg1fX9zVBo38p9tZ1/idMmiZ1VB8vGqTgVrT2lmyM0B5kBXjbHnU4QOslb2c8BSKx7RiAgAr5NlQChNCa27v2kQcrIDyuhQ+wAgvoa7F8uiUhxyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RqjoJ08H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z32K1vqi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RqjoJ08H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z32K1vqi"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744041475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoZTyxyOl/UusotlNwi01NhNZ9SZTPvd42O5pjsTrkE=;
	b=RqjoJ08HqXAJvxvRLhF6rJWvVNnYqXfzt2j+jYch9bW2owViw/OE/7Z9Nrz6kWnh6O6B6Y
	IJc6W9qj9TmbJAEtNhBkuxwFjOQg/k1XPhBUR1zZ+aRJgMZzeAWBCzogtEsamvUFj9SdiK
	IidbNcIywLG1qrljmAhG1DPEalKE1oLLvzXSI6YKyq52c68PbLWtxPsuhTn6/XS9fiN4OE
	pZX7p4tGAv/r8HDhDCEOHvjZMG0kNWToPSg9OKdEYX9FO0rQdLn+61YC4/3QvEA1mEm6NV
	OWLMJ0OYqg8wOCar2sPLJjnhCH9p6K1BuhlYk7PgYBpMV+zFu+FMmV2FhbI3xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744041475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoZTyxyOl/UusotlNwi01NhNZ9SZTPvd42O5pjsTrkE=;
	b=Z32K1vqiDfF3xv8KRuxTh/eGNMnZTQXA7hrC7CDRa1V++hZP5Y9/zKeobzdUFMBBMIj2Tc
	DAvp44XVwbwYOyCQ==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v11 19/19] futex: Allow to make the private hash immutable.
Date: Mon,  7 Apr 2025 17:57:42 +0200
Message-ID: <20250407155742.968816-20-bigeasy@linutronix.de>
In-Reply-To: <20250407155742.968816-1-bigeasy@linutronix.de>
References: <20250407155742.968816-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

My initial testing showed that
	perf bench futex hash

reported less operations/sec with private hash. After using the same
amount of buckets in the private hash as used by the global hash then
the operations/sec were about the same.

This changed once the private hash became resizable. This feature added
a RCU section and reference counting via atomic inc+dec operation into
the hot path.
The reference counting can be avoided if the private hash is made
immutable.
Extend PR_FUTEX_HASH_SET_SLOTS by a fourth argument which denotes if the
private should be made immutable. Once set (to true) the a further
resize is not allowed (same if set to global hash).
Add PR_FUTEX_HASH_GET_IMMUTABLE which returns true if the hash can not
be changed.
Update "perf bench" suite.

For comparison, results of "perf bench futex hash -s":
- Xeon CPU E5-2650, 2 NUMA nodes, total 32 CPUs:
  - Before the introducing task local hash
    shared  Averaged 1.487.148 operations/sec (+- 0,53%), total secs =3D 10
    private Averaged 2.192.405 operations/sec (+- 0,07%), total secs =3D 10

  - With the series
    shared  Averaged 1.326.342 operations/sec (+- 0,41%), total secs =3D 10
    -b128   Averaged   141.394 operations/sec (+- 1,15%), total secs =3D 10
    -Ib128  Averaged   851.490 operations/sec (+- 0,67%), total secs =3D 10
    -b8192  Averaged   131.321 operations/sec (+- 2,13%), total secs =3D 10
    -Ib8192 Averaged 1.923.077 operations/sec (+- 0,61%), total secs =3D 10
    128 is the default allocation of hash buckets.
    8192 was the previous amount of allocated hash buckets.

- Xeon(R) CPU E7-8890 v3, 4 NUMA nodes, total 144 CPUs:
  - Before the introducing task local hash
    shared   Averaged 1.810.936 operations/sec (+- 0,26%), total secs =3D 20
    private  Averaged 2.505.801 operations/sec (+- 0,05%), total secs =3D 20

  - With the series
    shared   Averaged 1.589.002 operations/sec (+- 0,25%), total secs =3D 20
    -b1024   Averaged    42.410 operations/sec (+- 0,20%), total secs =3D 20
    -Ib1024  Averaged   740.638 operations/sec (+- 1,51%), total secs =3D 20
    -b65536  Averaged    48.811 operations/sec (+- 1,35%), total secs =3D 20
    -Ib65536 Averaged 1.963.165 operations/sec (+- 0,18%), total secs =3D 20
    1024 is the default allocation of hash buckets.
    65536 was the previous amount of allocated hash buckets.

Cc: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h                  |  2 +-
 include/uapi/linux/prctl.h             |  1 +
 kernel/futex/core.c                    | 42 ++++++++++++++++++++++----
 kernel/sys.c                           |  2 +-
 tools/include/uapi/linux/prctl.h       |  1 +
 tools/perf/bench/futex-hash.c          |  1 +
 tools/perf/bench/futex-lock-pi.c       |  1 +
 tools/perf/bench/futex-requeue.c       |  1 +
 tools/perf/bench/futex-wake-parallel.c |  1 +
 tools/perf/bench/futex-wake.c          |  1 +
 tools/perf/bench/futex.c               |  8 +++--
 tools/perf/bench/futex.h               |  1 +
 12 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index ee48dcfbfe59d..96c7229856d97 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -80,7 +80,7 @@ void futex_exec_release(struct task_struct *tsk);
=20
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
-int futex_hash_prctl(unsigned long arg2, unsigned long arg3);
+int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long=
 arg4);
=20
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 int futex_hash_allocate_default(void);
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 3b93fb906e3c5..21f30b3ded74b 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -368,5 +368,6 @@ struct prctl_mm_map {
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
 # define PR_FUTEX_HASH_GET_SLOTS	2
+# define PR_FUTEX_HASH_GET_IMMUTABLE	3
=20
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 5b8609c8729e7..44bb9eeb0a9c1 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -70,6 +70,7 @@ struct futex_private_hash {
 	struct rcu_head	rcu;
 	void		*mm;
 	bool		custom;
+	bool		immutable;
 	struct futex_hash_bucket queues[];
 };
=20
@@ -139,12 +140,16 @@ static inline bool futex_key_is_private(union futex_k=
ey *key)
=20
 bool futex_private_hash_get(struct futex_private_hash *fph)
 {
+	if (fph->immutable)
+		return true;
 	return rcuref_get(&fph->users);
 }
=20
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
 	/* Ignore return value, last put is verified via rcuref_is_dead() */
+	if (fph->immutable)
+		return;
 	if (rcuref_put(&fph->users))
 		wake_up_var(fph->mm);
 }
@@ -284,6 +289,8 @@ struct futex_private_hash *futex_private_hash(void)
 		if (!fph)
 			return NULL;
=20
+		if (fph->immutable)
+			return fph;
 		if (rcuref_get(&fph->users))
 			return fph;
 	}
@@ -1558,7 +1565,7 @@ static bool futex_hash_less(struct futex_private_hash=
 *a,
 	return false; /* equal */
 }
=20
-static int futex_hash_allocate(unsigned int hash_slots, bool custom)
+static int futex_hash_allocate(unsigned int hash_slots, unsigned int immut=
able, bool custom)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct futex_private_hash *fph;
@@ -1572,7 +1579,7 @@ static int futex_hash_allocate(unsigned int hash_slot=
s, bool custom)
 	 */
 	scoped_guard(rcu) {
 		fph =3D rcu_dereference(mm->futex_phash);
-		if (fph && !fph->hash_mask) {
+		if (fph && (!fph->hash_mask || fph->immutable)) {
 			if (custom)
 				return -EBUSY;
 			return 0;
@@ -1586,6 +1593,7 @@ static int futex_hash_allocate(unsigned int hash_slot=
s, bool custom)
 	rcuref_init(&fph->users, 1);
 	fph->hash_mask =3D hash_slots ? hash_slots - 1 : 0;
 	fph->custom =3D custom;
+	fph->immutable =3D !!immutable;
 	fph->mm =3D mm;
=20
 	for (i =3D 0; i < hash_slots; i++)
@@ -1678,7 +1686,7 @@ int futex_hash_allocate_default(void)
 	if (current_buckets >=3D buckets)
 		return 0;
=20
-	return futex_hash_allocate(buckets, false);
+	return futex_hash_allocate(buckets, 0, false);
 }
=20
 static int futex_hash_get_slots(void)
@@ -1692,9 +1700,22 @@ static int futex_hash_get_slots(void)
 	return 0;
 }
=20
+static int futex_hash_get_immutable(void)
+{
+	struct futex_private_hash *fph;
+
+	guard(rcu)();
+	fph =3D rcu_dereference(current->mm->futex_phash);
+	if (fph && fph->immutable)
+		return 1;
+	if (fph && !fph->hash_mask)
+		return 1;
+	return 0;
+}
+
 #else
=20
-static int futex_hash_allocate(unsigned int hash_slots, bool custom)
+static int futex_hash_allocate(unsigned int hash_slots, unsigned int immut=
able, bool custom)
 {
 	return -EINVAL;
 }
@@ -1703,21 +1724,30 @@ static int futex_hash_get_slots(void)
 {
 	return 0;
 }
+
+static int futex_hash_get_immutable(void)
+{
+	return 0;
+}
 #endif
=20
-int futex_hash_prctl(unsigned long arg2, unsigned long arg3)
+int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long=
 arg4)
 {
 	int ret;
=20
 	switch (arg2) {
 	case PR_FUTEX_HASH_SET_SLOTS:
-		ret =3D futex_hash_allocate(arg3, true);
+		ret =3D futex_hash_allocate(arg3, arg4, true);
 		break;
=20
 	case PR_FUTEX_HASH_GET_SLOTS:
 		ret =3D futex_hash_get_slots();
 		break;
=20
+	case PR_FUTEX_HASH_GET_IMMUTABLE:
+		ret =3D futex_hash_get_immutable();
+		break;
+
 	default:
 		ret =3D -EINVAL;
 		break;
diff --git a/kernel/sys.c b/kernel/sys.c
index d446d8ecb0b33..adc0de0aa364a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2822,7 +2822,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, ar=
g2, unsigned long, arg3,
 		error =3D posixtimer_create_prctl(arg2);
 		break;
 	case PR_FUTEX_HASH:
-		error =3D futex_hash_prctl(arg2, arg3);
+		error =3D futex_hash_prctl(arg2, arg3, arg4);
 		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/pr=
ctl.h
index 3b93fb906e3c5..21f30b3ded74b 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -368,5 +368,6 @@ struct prctl_mm_map {
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
 # define PR_FUTEX_HASH_GET_SLOTS	2
+# define PR_FUTEX_HASH_GET_IMMUTABLE	3
=20
 #endif /* _LINUX_PRCTL_H */
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index c843bd8543c74..fdf133c9520f7 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -57,6 +57,7 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
+	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash =
buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in second=
s)"),
 	OPT_UINTEGER('f', "futexes", &params.nfutexes, "Specify amount of futexes=
 per threads"),
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock=
-pi.c
index 40640b6744279..5144a158512cc 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -47,6 +47,7 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
+	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash =
buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in second=
s)"),
 	OPT_BOOLEAN( 'M', "multi",   &params.multi, "Use multiple futexes"),
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requ=
eue.c
index 0748b0fd689e8..a2f91ee1950b3 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -52,6 +52,7 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
+	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash =
buckets immutable"),
 	OPT_UINTEGER('t', "threads",  &params.nthreads, "Specify amount of thread=
s"),
 	OPT_UINTEGER('q', "nrequeue", &params.nrequeue, "Specify amount of thread=
s to requeue at once"),
 	OPT_BOOLEAN( 's', "silent",   &params.silent, "Silent mode: do not displa=
y data/details"),
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/fute=
x-wake-parallel.c
index 6aede7c46b337..ee66482c29fd1 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -63,6 +63,7 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
+	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash =
buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('w', "nwakers", &params.nwakes, "Specify amount of waking th=
reads"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display=
 data/details"),
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index a31fc1563862e..8d6107f7cd941 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -52,6 +52,7 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
+	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash =
buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('w', "nwakes",  &params.nwakes, "Specify amount of threads t=
o wake at once"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display=
 data/details"),
diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
index 8109d6bf3ede2..bed3b6e46d109 100644
--- a/tools/perf/bench/futex.c
+++ b/tools/perf/bench/futex.c
@@ -14,7 +14,7 @@ void futex_set_nbuckets_param(struct bench_futex_paramete=
rs *params)
 	if (params->nbuckets < 0)
 		return;
=20
-	ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets);
+	ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, p=
arams->buckets_immutable);
 	if (ret) {
 		printf("Requesting %d hash buckets failed: %d/%m\n",
 		       params->nbuckets, ret);
@@ -38,11 +38,13 @@ void futex_print_nbuckets(struct bench_futex_parameters=
 *params)
 			printf("Requested: %d in usage: %d\n", params->nbuckets, ret);
 			err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
 		}
+		ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_IMMUTABLE);
 		if (params->nbuckets =3D=3D 0)
 			ret =3D asprintf(&futex_hash_mode, "Futex hashing: global hash");
 		else
-			ret =3D asprintf(&futex_hash_mode, "Futex hashing: %d hash buckets",
-				       params->nbuckets);
+			ret =3D asprintf(&futex_hash_mode, "Futex hashing: %d hash buckets %s",
+				       params->nbuckets,
+				       ret =3D=3D 1 ? "(immutable)" : "");
 	} else {
 		if (ret <=3D 0) {
 			ret =3D asprintf(&futex_hash_mode, "Futex hashing: global hash");
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index dd295d27044ac..9c9a73f9d865e 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -26,6 +26,7 @@ struct bench_futex_parameters {
 	unsigned int nwakes;
 	unsigned int nrequeue;
 	int nbuckets;
+	bool buckets_immutable;
 };
=20
 /**
--=20
2.49.0

