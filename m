Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567886;
	b=BlZ87G1ZBcTjYCozsHnv8LMj4GL40Uy5l7KoE2seYJbAxqrFTiC2/AunlT013cOaDYf2
	 O7c04BHzrY8YqlTrbPLlSe3cTbecw0/raMlGsMwZ17YdVHn7yJAw75zTsCZzSNdt4YWzv
	 C8KX2wiyRkV8XWV04z6YAl9MTyDoLsWeqdB4ID2qyCkE/k3Zw5lRCT3rtugDWxXljieja
	 f5Xt6vUGPsVtGX+ptXRyeFypfzgAHHOrZyr04WoG+i0UC4XLeleeFebRjJ+w8gW2acaQT
	 grQwmLbP9GDt7bFe29ZxgN2WZvYqWNYBTNxcTUsWbiUO/If9iDi/GO4KRcAjVDpsb4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0Bm9NXQn0v9M2tyfxAozRt5jQau1vpJZk8wO8ZZv9cE=;
	b=5dxClZ1puVEeg4Is8XKqT/ELF74pc3hl72Eeu/2Jdz1JBLX6gDuxgZnWl2mqg+qKguA9
	 4ueYrGJMV9kSpnNJGIhYGukETEmH4QMW6cHll002o9QTgt0WjfH2nlfwxCc80tnpmiCZN
	 83zutMUN5IKt75HRXiAyi7MLx8GoU1aGu6J/oaJXyGI9vsOB1Akz2U9BVXJ8PocB/UYFN
	 opGUE+SGwVRdMy+Jl0u1H7qT37E/LGtixpkB/thH2K49+fJXKIfoZunwPk+4Hs1FB6NgY
	 W/f/t2eSxiJ423n3TwgKlBiLF3q1u7SIIejzTgyzPccL1EgJGU55fwQt0So7pimGNmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hGl4ayoc;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8488606A683
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8488606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hGl4ayoc
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso6898694eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567885; x=1796172685; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Bm9NXQn0v9M2tyfxAozRt5jQau1vpJZk8wO8ZZv9cE=;
        b=hGl4ayocEX9r6evkVwQoj0cjaNV1eTxHvPVmiy3qklo0GBOKY/Vqu0SaA1NrQNhTxZ
         Pcga+1U3bUy0cKt9PVlVBowS2x1IoS2tfeQZis3i49cFBo4hwVYrfUKmgRunhFXL/S5F
         JWBrW6/gw3Hb+COVmRqu1cr00rB7eVWQlo/Y5LdRMO6rpc2BA2Y9hrzwaPxC9Lw7TEEe
         kPjVRiIAe9+FU77VM4mimnAEHljfrCr+Hj7l+VGYSSDKPHremnSHuxkk7TRjlvc/I0KV
         u0jBx/XaISOEpsd5A1xvrXpIkvYH7WYDMrEmajE7R70+L+rXLO62WfculirBEGeBn03c
         rH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567885; x=1796172685;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Bm9NXQn0v9M2tyfxAozRt5jQau1vpJZk8wO8ZZv9cE=;
        b=GOg8+o5nC7KsCrxJ+yed3BFd74i+H6MG4AaWtSIAMYNQ0i9px0KVvVn1PhmxTQIHzr
         LZjByqdeIJCgiC3zRlitZq7zolaQbpT33wNqOpQCYxoxwv/HJf55qhkcw7OX41aj38EW
         cVPSWtiuGQD5c+fDSgczbJezYAVHugvmdYvUKuYhUjh0BKzacUIqlCTuiiH0789gqD25
         Zwfbs6m7uHzYYuPA4ofX8thVtDNT6uKM6l9rvw6YExkQPHS5c1RR6kWKj68CuaM7z1p5
         lF9uZqGb69wCUn78YvXh0dKKRzQokp5lozOkwuji3nKVhlQ9na6hz7mNtEegCrdDSB+2
         l9GQ==
X-Forwarded-Encrypted: i=1; AL+hErETKiQk9MLRAmIE72owmC9jict5Kn0iuXlGjFbd22XDNvMhjZIb/+jQxwjHuNCvmvxkvJYEU5ohxqjiT340YyFG@vger.kernel.org
X-Gm-Message-State: APuU4Z+zSzHYOpKuuxKVhIq3nD4xtu3h215cIhcCX+pgqtx9fMJHs9Lk
	UAHmhinHzWvnp8KF7M8M4pan4tgSlULjTr7pFrBQk2jpm0Uom+zm5lCxCdLJHIBtzlhH7LCp6Rj
	nCdtEXUcldg==
X-Received: from dybcn8.prod.google.com ([2002:a05:7300:a908:b0:36f:5688:8a11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:182:b0:386:b4db:74d3
 with SMTP id 5a478bee46e88-386b4db7924mr6776155eec.21.1795567884395; Tue, 24
 Nov 2026 16:51:24 -0800 (PST)
Date: Tue, 24 Nov 2026 16:50:51 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-3-irogers@google.com>
Subject: [PATCH v4 02/19] perf/uapi: Factor perf_build_id out into its own
 top-level struct
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Document struct perf_build_id as a top-level structure in the perf_event
UAPI comment and add it to the PERF_RECORD_MMAP2 union comment so future
sample types can reference struct perf_build_id directly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/uapi/linux/perf_event.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index c49fc76292f7..deb7c42d109b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1099,6 +1099,18 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_SAMPLE			= 9,
 
+	/*
+	 * Build IDs may be present in a number of events. They have a
+	 * consistent encoding of:
+	 *
+	 * struct perf_build_id {
+	 *	u8		size;
+	 *	u8		__reserved_1;
+	 *	u16		__reserved_2;
+	 *	u8		data[20];
+	 * };
+	 */
+
 	/*
 	 * The MMAP2 records are an augmented version of MMAP, they add
 	 * maj, min, ino numbers to be used to uniquely identify each mapping
@@ -1123,6 +1135,7 @@ enum perf_event_type {
 	 *			u16		__reserved_2;
 	 *			u8		build_id[20];
 	 *		};
+	 *		struct perf_build_id	bid;
 	 *	};
 	 *	u32				prot, flags;
 	 *	char				filename[];
-- 
2.56.1.831.g720f3f5937-goog

