Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622196;
	b=U5T0tyoPXt/tWptit91GKSmbzyBG8PDmEKwz5u75PkdM8nuKunauBIFekdXagPvDgyCN
	 XvyGBo5AOZcqTX0m8+FN7Tm3wLz2UVrY2I9zcFZy1+UUHNIUUxpha/eSXV3obb9SMvImu
	 VMIpIHnWaHbI4xleaane1oOKgTEHqqZO0tjFTnpmIBLn/qyoqTvJ7rtrsCI3j9tshtwMh
	 BuQ5D38s2p2OfEBg+54PfJkwTOvXoH3fqB7d4rz6npFZAQmX6IIIawQgvqejRL7n94PLc
	 Yh8Y9mYlcz1EW5F1dsFupUcPm8WjiQXMmOJPVQvEkQ5sqyxqBbc1nTJjrJcXLvT1HQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622196;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DKR000uefef+Vmpc1ME2SEAH5liXbSLg55lYZ92unUA=;
	b=QLm45ndSJODfdoXBzP10hFUv4nm+z/XVXcUls7g2H3r9OIX01Vfc2RA/fDPUWdaqsGjg
	 RFSWuEjKmghsSJDJZGTfrC6kOKVkU4kKYactgiWoIxjxXbcDHprUTHnCbXJA9BvQdtb2k
	 Ie4tyVwaRpCQVAbQDXjMrD3nm8KYZWVnTw7FAEeAJY/lB3Tb7gfb/ycOoP6FFom6JQQjM
	 yvyE+eDlRWdx4rBV7flBJMId5083XE56ghFpTa0MgNocExOHH8aFIe5JQbMqdseigzKWe
	 NG6+tm5PY9Tq6+xQQV7OxgEowWJcnHWFHV4F26nJNeYBYRTlcR+3e2toxPWHGOu+WHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6RNlr3f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6D606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6RNlr3f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B4B1F000C4;
	Wed, 21 Oct 2026 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622195;
	bh=DKR000uefef+Vmpc1ME2SEAH5liXbSLg55lYZ92unUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y6RNlr3fxEMHHzK8gTX1cPZ6gz+HnkzuPloNijLu5bl2S6j3q3q1aTecyxoXPGXqY
	 yQPTb8vWITsYXbAAi1Lc9Dn/tYNH+gj5+RRj+t1/nDl0+bqPn72EoBM/1evtoeq/Li
	 B0orEDSHAKYNuACFo1GgTJca31b2Dr3JqLU62WXlamY49kwy2Mm3+S3ulzamOK1eCz
	 lL7y6ySC8xy8+lbMi+HWnVoVFRxD7sv1limlOzJtH6XyH0RtIh+hkVXZUoOhsFNMIN
	 QWnYrADL0zBv8U5RxmgHKQ1kou7lHLU+1Jqv2WD79f0yZ6szl4EG0c+7B+msdVHezF
	 nXP+CuTSnmtfQ==
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
Subject: [PATCH v2 09/12] tools headers: Sync UAPI linux/fs.h with the kernel sources
Date: Wed, 21 Oct 2026 19:35:48 -0300
Message-ID: <20261021223555.28372-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021223555.28372-1-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
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

