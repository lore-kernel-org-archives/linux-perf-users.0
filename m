Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693505;
	b=dlH89gUWvORj9AqktATSTBPK5KbJcUwX3kL3LpaG5MG3Ahduo5O9iAFLaxXD4zJWYoyp
	 MPFuBcNd0LJILZcheJaGIhahKnztXoqfG032JV9waSe8vWTKrTb0/Lv0SkOkBzT5ziIKH
	 vGrhVagD/k/PaemWV8AdaWv8PNsEElDZw1zTNbhqa1zj+rq5Qe5igimr2ugcj8DnVNetY
	 OEzlaxLwxGiOfDJP15468CPoRGAmHrgPxZ7LVHcElt5gUffY3G9afqPtcpl93LDRXBvmp
	 aidOhsRIrcd9R6VPh3qRkQNUOq1bk54eJN/uP7aHCA1tXGhUKhDdGrONu/7OjCGAbdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693505;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DKR000uefef+Vmpc1ME2SEAH5liXbSLg55lYZ92unUA=;
	b=3DGX3irEwevEQM4VoKhRcesnTptoH3SxbncQXXCZgClq72pGLqnO4uIMCuGFSZpcGZn5
	 9ptzDPavh1sjdC8fTcYTppsSRDdUUkH+tweL4nmZ7o+6MqzuTR9qJ5Sfk6qoX7WKq0b9s
	 KTtxsRUizw47UVhDlVYn0DdLDxdlWjax1w9ZU2Okqlmql99fp2cJZ1H/1ZefaiW5mDgBr
	 O6aMH8YkwV0I0ipqPoX1Sx1NbywkR0mdUntkoRPnqggg2G8IaHWGHMgaRlT4KdALB/9tX
	 FTfmYC4rKjsh5I9h8AdU4wD+h5AgY1z74HEVGHYORJmUDFM/sEDMKzIH1jhBSDzIWUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCFeBfsT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5073606A322
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCFeBfsT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819BF1F01828;
	Thu, 22 Oct 2026 18:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693504;
	bh=DKR000uefef+Vmpc1ME2SEAH5liXbSLg55lYZ92unUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bCFeBfsTL00V0DM71UGSzOaRbAx3+8cc/n6qe7DeYwbmko6Ni/L93IYADfG3LSO4C
	 qEtrldb5pzefu+V3Gy5JrKSA0D/hIxXJNxZPVSSM/vzx+cojWqKpSHPlwT7DsmpbZa
	 qiyGkfqpuCBKlklf9PGGUvcYRh/lrq2nPJIw2pbpiy94t9pVQxiQk8g6ISeT16kQNl
	 CM+uAL+Ff3lrNF4Rmc4xPGIRi5gYlS50lGMECFqTYId3opWgTqVMbLexFPIZ8cJY86
	 W/7lcuY/9IGcLK0Zc2RXf/ifmeB/B/XL5a7M85x9e7sq1+nQ5oWy73FIzLbZ9TrWhy
	 rvc7MFd5LFTiw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v3 07/10] tools headers: Sync UAPI linux/fs.h with the kernel sources
Date: Thu, 22 Oct 2026 15:24:26 -0300
Message-ID: <20261022182431.25673-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022182431.25673-1-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  21a62663d473 ("fs: fix typos in comments")
  338964881982 ("mm/pagemap: add PAGE_IS_ACCESSED for RWP tracking")

That don't result in changes to the string tables generated from this header.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h

Please see tools/include/uapi/README for further details.

Cc: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/uapi/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
index ee2203d606436f42..a46c33692aa21af0 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fs.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fs.h
@@ -471,6 +471,7 @@ typedef int __bitwise __kernel_rwf_t;
 #define PAGE_IS_HUGE		(1 << 6)
 #define PAGE_IS_SOFT_DIRTY	(1 << 7)
 #define PAGE_IS_GUARD		(1 << 8)
+#define PAGE_IS_ACCESSED	(1 << 9)
 
 /*
  * struct page_region - Page region with flags
-- 
2.56.0

