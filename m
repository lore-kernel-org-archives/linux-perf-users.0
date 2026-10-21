Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618252;
	b=fqvrjBstQ1NCZeQESwQtKX7ox0JfVL0uuCUzwqaA05tdKkgP5OJPGToQcYomEN+aqx7X
	 jUkD4XoA6Z+iI0A1cQMtZ330DCN9yCI7fzSL724X8QiCcVUK+FCK8rmbhOLeR0dy12akQ
	 VO7AanzrbXSwV6O3matFyd/5kCtU6V9b7oTlLhG7ER7lghQm101Rvd2SYHklc9ZSICeaM
	 CN6IlSu5lvEkpE5B8DK+xYAPV+QFlz9be0y+sjxp3jZg9xMLQbX0kcEa22EF5R5exJEV+
	 ZzTE/Cr4AeE32fXhoFrtBiVI07BqUgU23koj+5aHeOE2/Q/y/hyiBuAeumyDAIyeuDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618252;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DKR000uefef+Vmpc1ME2SEAH5liXbSLg55lYZ92unUA=;
	b=VyPjZzwd14Q1Dx+X+wbVr5N2fqtonpO6+HK6Dbzjz19IBPHRsnbVXg4Bf/oN3EEea3s/
	 mq+TDox2CeitoMkrV9iQQd5iGokG3UCteRAkl8VVLpbz5h/JA0GTw5XHWGqyK1eMycACM
	 ggH66gzgzl7L+MLh3Ui+L/1lPpX/11HZroXwzW9VsRCJdhYAD8w9qnhy7LV+2frlVuCd3
	 aQzdeLS8zyTbhySg77D5qgupZUsXQWXAiiwDT8S6Ez/AoJOS147lcf5a/skNfYWRJmOX/
	 cSc2KQxEGjju1L1EoiglfNFEHHm70/K8UhRLLWFkZjUQRILMdcr+lgZmIHU3/PfX87A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOiuVxsh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADD606A31E;
	Wed, 21 Oct 2026 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOiuVxsh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92A11F000C2;
	Wed, 21 Oct 2026 21:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618251;
	bh=DKR000uefef+Vmpc1ME2SEAH5liXbSLg55lYZ92unUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gOiuVxshlNyou4M4f2E2CE9UOYd9eJhOF+gTdnTA60u1ByYzjgZv0crLSIlNAjmsV
	 rZsYcU3sOibWW3Ab6KhPbT3mrhDdBbbwPkerIKcUkj0hHhJIcnUwn7oA594UfcmP2s
	 kBIDg14KMGrBt2vLs0nN1H+4PxSuLaEvir4CEPSyHYF6W7A51CscSNhOo5G8KPMIQu
	 EJYToFtPOBdxwhbWunXnnMzokYuExVgWjHJbxSNd+Sf7szNXucxgDhdyUdtwqwfXmF
	 LQ6kVJLLaXRiUh5yvT+HC6qb3FVs8vhmcWdud8XAS1z/ROrQYofaCyccazww8Lwx/P
	 mpGMppuRKpmhQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v1 09/12] tools headers: Sync UAPI linux/fs.h with the kernel sources
Date: Wed, 21 Oct 2026 18:30:03 -0300
Message-ID: <20261021213007.21046-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021213007.21046-1-acme@kernel.org>
References: <20261021213007.21046-1-acme@kernel.org>
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

