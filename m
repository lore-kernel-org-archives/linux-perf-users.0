Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C372E6D33;
	Thu, 10 Jul 2025 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145225; cv=none; b=LJFEKO28uEGLVyFlUwZsOmsh4EcoJbOS3h5dP6oLkDDyODGh66GZmalIh7xxIMIm5JlZpxvWIA7hQynB59m0uypSnINC9StxQtiFAvUWlgg2I1ugF+FHKoJ3m67HYG391De+l+5sH4TlUtwaksIboxK/IvdN/OXp9xmsOrXfyoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145225; c=relaxed/simple;
	bh=VMVrky7aEFXB1dsuXoZKTUr/9FXsjEpD11b0L6/8koo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqpfiK34w62aMM76enNFY4IM2hSdXz6ikU3fjnqFkF9QIYIV8ZgqGcsUTVFbO67QIw7zg4+g3SAVtcZyg19vOr7mtPCKYu+eRkVSIVR2OH2fWXb7VxCsNVglzmEFk5ZfFR9GyDNGVV1YqwaRzveFNqZtBLGBQYcxfsDngrHbisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k9NMBjNI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o1IrUWpI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k9NMBjNI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o1IrUWpI"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752145221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXOx5tAvnAjtoJdjEyryVJUnZ+UnzqrMm9Wls9voAK0=;
	b=k9NMBjNIoPXUZSO6UXx2XkTapOSLDJ65Qj+jO6gR9sUj+IAaNm0XIZfule8s0RrPkdeNw1
	hYtIo3KT/aUd4ZKnGtx1F3VfxCgekO73sHA4tJADcYSb6+1XS9gpaAG8j/Ouy9Mdb8RjnF
	ab0VVgVFbNFlOAhG/1WFDLEYTdxS8afkMVuOMgZI+0D43j1VJvc4+kip3YCLPU18uB6E4+
	VF88VfkrF5gAq9fYjXyjuGHGaFFeQIxq78FUSUABh/T4nbwa2iuyX0KHQPp9ImkM7X3HDK
	30UxsCmOdAKqxYqcJWTOC7BjECQW6H2BxOKD7IQk94WVTpMH6EiPrxASi7jgDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752145221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXOx5tAvnAjtoJdjEyryVJUnZ+UnzqrMm9Wls9voAK0=;
	b=o1IrUWpIBNW/LmaOcvkFndWUL6YYKWXZTgTcaV5GAadPM+bM9uVQjH+UNUlaLu1BuyQ8M9
	6Ky28uP4SfdMLgAA==
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
Subject: [PATCH v2 6/6] perf bench futex: Remove support for IMMUTABLE
Date: Thu, 10 Jul 2025 13:00:11 +0200
Message-ID: <20250710110011.384614-7-bigeasy@linutronix.de>
In-Reply-To: <20250710110011.384614-1-bigeasy@linutronix.de>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It has been decided to remove the support IMMUTABLE futex.
perf bench was one of the eary users for testing purposes. Now that the
API is removed before it could be used in an official release, remove
the bits from perf, too.

Remove Remove support for IMMUTABLE futex.

Cc: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/include/uapi/linux/prctl.h              |  2 --
 tools/perf/bench/futex-hash.c                 |  1 -
 tools/perf/bench/futex-lock-pi.c              |  1 -
 tools/perf/bench/futex-requeue.c              |  1 -
 tools/perf/bench/futex-wake-parallel.c        |  1 -
 tools/perf/bench/futex-wake.c                 |  1 -
 tools/perf/bench/futex.c                      | 21 +++++--------------
 tools/perf/bench/futex.h                      |  1 -
 .../trace/beauty/include/uapi/linux/prctl.h   |  2 --
 9 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/pr=
ctl.h
index 43dec6eed559a..3b93fb906e3c5 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -367,8 +367,6 @@ struct prctl_mm_map {
 /* FUTEX hash management */
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
-# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
-# define PR_FUTEX_HASH_GET_IMMUTABLE	3
=20
 #endif /* _LINUX_PRCTL_H */
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index d2d6d7f3ea331..7e29f04da7449 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -56,7 +56,6 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash =
buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in second=
s)"),
 	OPT_UINTEGER('f', "futexes", &params.nfutexes, "Specify amount of futexes=
 per threads"),
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock=
-pi.c
index 5144a158512cc..40640b6744279 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -47,7 +47,6 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash =
buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in second=
s)"),
 	OPT_BOOLEAN( 'M', "multi",   &params.multi, "Use multiple futexes"),
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requ=
eue.c
index a2f91ee1950b3..0748b0fd689e8 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -52,7 +52,6 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash =
buckets immutable"),
 	OPT_UINTEGER('t', "threads",  &params.nthreads, "Specify amount of thread=
s"),
 	OPT_UINTEGER('q', "nrequeue", &params.nrequeue, "Specify amount of thread=
s to requeue at once"),
 	OPT_BOOLEAN( 's', "silent",   &params.silent, "Silent mode: do not displa=
y data/details"),
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/fute=
x-wake-parallel.c
index ee66482c29fd1..6aede7c46b337 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -63,7 +63,6 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash =
buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('w', "nwakers", &params.nwakes, "Specify amount of waking th=
reads"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display=
 data/details"),
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 8d6107f7cd941..a31fc1563862e 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -52,7 +52,6 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash =
buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('w', "nwakes",  &params.nwakes, "Specify amount of threads t=
o wake at once"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display=
 data/details"),
diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
index 4c4fee107e591..1481196a22f0c 100644
--- a/tools/perf/bench/futex.c
+++ b/tools/perf/bench/futex.c
@@ -9,21 +9,17 @@
 #ifndef PR_FUTEX_HASH
 #define PR_FUTEX_HASH                   78
 # define PR_FUTEX_HASH_SET_SLOTS        1
-# define FH_FLAG_IMMUTABLE              (1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS        2
-# define PR_FUTEX_HASH_GET_IMMUTABLE    3
 #endif // PR_FUTEX_HASH
=20
 void futex_set_nbuckets_param(struct bench_futex_parameters *params)
 {
-	unsigned long flags;
 	int ret;
=20
 	if (params->nbuckets < 0)
 		return;
=20
-	flags =3D params->buckets_immutable ? FH_FLAG_IMMUTABLE : 0;
-	ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, f=
lags);
+	ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, 0=
);
 	if (ret) {
 		printf("Requesting %d hash buckets failed: %d/%m\n",
 		       params->nbuckets, ret);
@@ -47,18 +43,11 @@ void futex_print_nbuckets(struct bench_futex_parameters=
 *params)
 			printf("Requested: %d in usage: %d\n", params->nbuckets, ret);
 			err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
 		}
-		if (params->nbuckets =3D=3D 0) {
+		if (params->nbuckets =3D=3D 0)
 			ret =3D asprintf(&futex_hash_mode, "Futex hashing: global hash");
-		} else {
-			ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_IMMUTABLE);
-			if (ret < 0) {
-				printf("Can't check if the hash is immutable: %m\n");
-				err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
-			}
-			ret =3D asprintf(&futex_hash_mode, "Futex hashing: %d hash buckets %s",
-				       params->nbuckets,
-				       ret =3D=3D 1 ? "(immutable)" : "");
-		}
+		else
+			ret =3D asprintf(&futex_hash_mode, "Futex hashing: %d hash buckets",
+				       params->nbuckets);
 	} else {
 		if (ret <=3D 0) {
 			ret =3D asprintf(&futex_hash_mode, "Futex hashing: global hash");
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index 9c9a73f9d865e..dd295d27044ac 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -26,7 +26,6 @@ struct bench_futex_parameters {
 	unsigned int nwakes;
 	unsigned int nrequeue;
 	int nbuckets;
-	bool buckets_immutable;
 };
=20
 /**
diff --git a/tools/perf/trace/beauty/include/uapi/linux/prctl.h b/tools/per=
f/trace/beauty/include/uapi/linux/prctl.h
index 43dec6eed559a..3b93fb906e3c5 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/prctl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
@@ -367,8 +367,6 @@ struct prctl_mm_map {
 /* FUTEX hash management */
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
-# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
-# define PR_FUTEX_HASH_GET_IMMUTABLE	3
=20
 #endif /* _LINUX_PRCTL_H */
--=20
2.50.0

