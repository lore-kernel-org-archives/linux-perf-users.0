Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838698;
	b=lDLjxPo8pCGAeg6WkZYXzuMjeY63w3X+ge0SgiUFiqp4Gphb4zEoxtu6bYmVPnvo+p8X
	 EqKG4d+q2fboyzFg+b6cyHabq/40KIZIP0cjKjrcZMw9LWc4BXSQSobE5cUI4gXcBinL6
	 216mf+/f1HK08coinKBC561zo0mVeqXI0luld96Oq//bJOlWnnoSjhWATSHWq2QfELZir
	 diw+vELOpK25QazGCuRVrxjP0x7dwY8FbO71wfRGepZKdyqvrq48mbO11VxXo1wF3nLz4
	 zpZOBa4OYe1NH30xnacBuNZ9V37QfaIRfU77c+h6vHmFTLmRIPcsRGtKtiZk57DOXFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838698;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8j65eSSWn/EEqAi9eftH5O3y7QuS/oV1lt57acdBekE=;
	b=v7eCO8hqw1EIL/Si42iXcrYDxItpBLp/1IOtl38KaqzSeN04b71rsFwImPDWkzF5N5MK
	 bF6Yf2Q1gBmIDyF+uMADp1ejGzeZdyqkFUPMmwryIizk/7V0Ggv+l9H03NZ2EN25gSuur
	 PQ/MK0VXjzT4wXwghlFuHbpEv4Iau065Kuix9R89X4ANpbBbEpjC7rHQWqxMkn87ui1NY
	 ynsiBnO5fAKRNtutkKwY6ee2ZCPTNNCDzMNIkoBD4SP9Y44TWXxGRjrvGxf6zTQ2kL7xD
	 ZuW+4faazq41q3syk3OsrJR0UaBa6jraVwL7I8z7+sB0T+Jz3gAD8e5S9lbI4oqjueQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=F6quFPOY;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=nAPQuaMr;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86864606A31B;
	Thu,  5 Nov 2026 00:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86864606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=F6quFPOY;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=nAPQuaMr
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1793838693; bh=8j65eSSWn/EEqAi9eftH5O3
	y7QuS/oV1lt57acdBekE=; b=F6quFPOYgfpIEHNwXIAv7EbTgIGkx/EhWJ+CVooTahsQrT4e7Y
	Zpf1MVkx9VomEWmlOdclH39WrU29FzTEuEJYaa1LKC5c1VfkH1tkVNZj80BeLsTIqpcq3+CqsjS
	fKu4QfNpU1gnramo9PjL0EWg+heXas43SaBHeC2hpYGlzASDnsWs73/rXKZ8uiWpaU0ohbZ7DAy
	jv/TchnkA/atMuLdNe9xvqMhniQUyaTQkro2U8IZ6C79/GPPFTgfdYQbXc0f6VbR6KtJRjcgIGz
	EwKOnWYKNzgf+B8M4ZEQiY3Owzm4ST9JmYw4hrkC6g4iXb9icgMjyW5QnqnXaUGtqcA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1793838693; bh=8j65eSSWn/EEqAi9eftH5O3
	y7QuS/oV1lt57acdBekE=; b=nAPQuaMrtuY5u/oY9kCy2chF7LLq31y7s/BrQtB6v1O/ENxFjT
	A2N2R59+fNfvDZwiijAlXaybdwm7WlVLiDBA==;
From: Bradley Morgan <brads@mainlining.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Wake Liu <wakel@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tools: pass the unused prctl() args explicitly for PR_FUTEX_HASH
Date: Thu,  5 Nov 2026 00:31:27 +0000
Message-ID: <20261105003129.3130709-2-brads@mainlining.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105003129.3130709-1-brads@mainlining.org>
References: <20261105003129.3130709-1-brads@mainlining.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prctl() is declared variadic in sys/prctl.h, so an argument the caller
leaves out of the call is whatever that register happens to hold.
Neither file passes all five.  The two SET_SLOTS calls leave arg5 out
and the two GET_SLOTS calls leave arg3, arg4 and arg5 out, so those are
whatever the registers hold.  The kernel does not look at them today so
it works, but it works by luck.  I checked that against a running
kernel, garbage in arg5 on SET_SLOTS and in all three on GET_SLOTS are
accepted.

Pass the zeros.  No functional change.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 tools/perf/bench/futex.c                                   | 4 ++--
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
index 1968c9d00b5bb..f4c1c30efe0bd 100644
--- a/tools/perf/bench/futex.c
+++ b/tools/perf/bench/futex.c
@@ -20,7 +20,7 @@ void futex_set_nbuckets_param(struct bench_futex_parameters *params)
 	if (params->nbuckets < 0)
 		return;
 
-	ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, 0);
+	ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, 0, 0);
 	if (ret) {
 		printf("Requesting %d hash buckets failed: %d/%m\n",
 		       params->nbuckets, ret);
@@ -33,7 +33,7 @@ void futex_print_nbuckets(struct bench_futex_parameters *params)
 	char *futex_hash_mode;
 	int ret;
 
-	ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);
+	ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS, 0, 0, 0);
 	if (params->nbuckets >= 0) {
 		if (ret != params->nbuckets) {
 			if (ret < 0) {
diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index a8742e2045402..96bfb72362221 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -32,12 +32,12 @@ static int counter;
 
 static int futex_hash_slots_set(unsigned int slots)
 {
-	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, slots, 0);
+	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, slots, 0, 0);
 }
 
 static int futex_hash_slots_get(void)
 {
-	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);
+	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS, 0, 0, 0);
 }
 
 static void futex_hash_slots_set_verify(struct __test_metadata *_metadata, int slots)
-- 
2.53.0
