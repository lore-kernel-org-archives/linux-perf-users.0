Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280118;
	b=W9PMGb1iHn8QZVZMgZe8XUoO3ZLKgfxPH4qop/UE9BTOZfQaJvDyLsrIW4ywscuHo9DB
	 yl19fFn/jIrH3dXhk8Oo9aIG94Pj3VDxFMaJ1GRAYWPULaobg0w33NpCX3PF2AB2KwpoE
	 gQh+8wpNXpIUxaHFR2UClBki/gG8u79b7rrsD7/bP9g14fy4xtSl6UAPKaPJEcy8srwU5
	 mz0H7OKVvfyFDqsfDMnA4q5WnFA0Wg2uYzkuUzrFSMFdtOIv0uykV7PctbK/hAf4S0O5M
	 TtfL9GtGEqv6CjmTt9rSKRjTZ6bsnqPAsmmIB4mLIsSl6qQFyg+p28bkSbInfa2Zw9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A5YmHynGJJVBsCpYTYxBmo8bTX3mRy6RGKfBohfukFU=;
	b=Y8KsGiGjrgTbCPiFNjEq6oXKZvgeWQiavBaSAn+kLLtLx//Ah8rFvWJ06c1p0ngWJD0O
	 2nu1eMXrkY00OzA+1otzRRxxywN/LTr5CADH8J0Are23byNIjeiCVa0sns7pmuLHN3n55
	 L5GLcOTIe9JR+3mmVtbZIx5MiL0+yGbV4Tum/Vzo7uhTqITetbeaoMh9B62DKW56gtD2J
	 d/c6HMNmsYgZHUoRio/lBEkRkVaPIinsEjaui9TmvVknkEKFXGbmYD/SkHHmXq73qL9vZ
	 klI5fNn1xbG+qRllOQco2D7Dat98rayfMO0UjO+jVmUaobSolrRaXXIBds05kf5E1jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=akXYympd;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF2606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 03:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65AF2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=akXYympd
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b244fb7fffso1973549c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 19:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280117; x=1794884917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A5YmHynGJJVBsCpYTYxBmo8bTX3mRy6RGKfBohfukFU=;
        b=akXYympdt6/WlV29/yfeBkAXelEroAJNkkZkr4XHh9fjQ3WEzlMfnRU5jDjRB2gxua
         wpBOGUphStwQRyYZ/AXIcW8UqQknq2sYajc71TD7SAZMuDQU04TWR4o1evirGc76hOA8
         y8aBmSxY8o1UImabq+FfmOOn0sFxEPhJPh9P4DztYeWnKHGxg4Z9p5EeNDFXcUDm8U/5
         qT/HMY4OZi7jIth2JKZq4yn8vm3f9dC/IlrDhr2Mir+gQburP03dHwCnqTlkaUqWheEb
         qSmK5596m+QJcMCa609t9yRmIA8jpsXlDTMTfMIoZb++3BTUWwGR2+ztjxmuCyPdoJk6
         m2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280117; x=1794884917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A5YmHynGJJVBsCpYTYxBmo8bTX3mRy6RGKfBohfukFU=;
        b=AESFhXswcqF/z/qSvVO/m46j70pKbUVn2zS/0TyKxPzC3cENPBQ1u8ZcVIx78CKnRT
         1l9JHMLs2hi+PU/o683TUaWlDtEbU+++NEa6iyEoI/7351H/fK1gfQxEkYdKPl7ehLdu
         A3++ysFDmeGv3SpUZLy/oRLv8PHKauJ3Q+HZuE9Ib2niVJCPDsXB4svuwbd8mzWPVE87
         8rMTIti3jWFVWmJGS/L1L0vYmgcCglhKK3ZiGPhqNAoxUVUWeBAr6tqkmAIwoZrHwpZB
         silE+rMG8uJI+jpxfpn1zE+IwrqniIB1zDfKHLzrmH749iQXBAwifj+t4ymtBPfluef6
         T5Wg==
X-Gm-Message-State: APuU4Z/gZ/tvqnFvaz7WGOBSTvPuL8wCiUxRoiJM19ET/DZl9kfM+nRn
	zPRW54AnwqUlOprR/a+oV5EGkCDKWHkYAby4xSRwyq3E9ikNL/iKFhZqZwCJQLiz
X-Gm-Gg: AYBFou3729rxfebu5Hgcx7mnv3MsYVCzuMS7aG7XEC22ohuRN/yHlF+ldr0vyLO5ZqL
	Siq+EMKcYVtVYTgNWmLAFYSVc6dOKNy7tdFdBVyXssAmfsRd36itEFXeSHhlvlupHLjMEl0wIEl
	lFuk+UbHv0jNzHnwyA2uHdVBpn+PS4sd4FoeRkzE1Gftm+tHO3oLcUi5pk+DNAhOVFsukzp5n0m
	0ihaF8HMZI0JCVceKox/ecrGh0UtBl/WYegUPXZOrfP9RDnDLue5i9y0OHj7Yhd6j4VXcZ42GUl
	836elQekCZQEf0H25Ziv8g2IrvSLNcncfXzl077SIsVPyb+sAArizi7hcAOYXWOMtUI/YAiCPtz
	SUCWrIlxFIAKT87hTuO6qEQG7hGVDFqnhrHm52gKTn0T+AC/4l4dIz5fvNrnxODH3VfUwZT8W4P
	OVy4A38PYH91F0vxa+VoEnonIoFmY4EM947hO+d101YADNyx+dpCG0XB9Sud+/D7pOhkWjnXGw1
	RYZLhBNi4KKdmyoFhvwlk4yPL8bCtPYfjbHrWZ0AyzyAtlpieCThXGI0YWcB5/dV12CyYPpttCJ
	QA4yQ5RdLqpMtQ9CbEhPc9DE/BUI8RKQEAUKCC54eqmkzPGLeW8scrwt9H0pRztinBw7KLVm2eO
	pG9TlyVSC
X-Received: by 2002:a05:7022:458b:b0:1b2:4871:b1f7 with SMTP id a92af1059eb24-1b3b602aee6mr2499114c88.39.1794280117042;
        Mon, 09 Nov 2026 19:08:37 -0800 (PST)
Received: from thinkpad.tail59a646.ts.net ([112.199.224.229])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890584sm3849149c88.3.2026.11.09.19.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:08:36 -0800 (PST)
From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
To: TAKANO Mitsuhiro <takano32@gmail.com>,
	Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf evsel: Skip group members without fds when walking a group
Date: Tue, 10 Nov 2026 11:08:23 +0800
Message-ID: <20261110030832.3060145-1-hang.zhengyang1010@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179277266830.1885600.10381796857085073613@gmail.com>
References: <20261023085629.1694941-1-takano32@gmail.com> <179277266830.1885600.10381796857085073613@gmail.com>
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

On Fri, 23 Oct 2026 16:24:28 +0000, TAKANO Mitsuhiro wrote:
> So get_group_fd() is not the cause here.

On x86 (AMD Zen 3, perf-tools-next 13a8d580433a) it is: cycles gets
the /proc/stat fd of user_time as group_fd and fails with EBADF.  Your
patch fixes the segfault for '{user_time,cycles}' with -a, -I, -r and
--delay, with no new perf test failures.

Tested-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>

To also get the member counted, get_group_fd() can return -1 for a
userspace PMU leader, as 0b18bced5444 describes, and the members then
must not use PERF_FORMAT_GROUP.  On top of your patch this makes
'{user_time,cycles,instructions}' count:

--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2370,6 +2370,10 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (!evsel->supported || evsel__is_group_leader(evsel))
 		return -1;
 
+	/* A userspace PMU leader has no perf event to group with */
+	if (evsel__is_non_perf_event_open_pmu(leader))
+		return -1;
+
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -721,7 +721,7 @@ static int create_perf_stat_counter(struct evsel *evsel,
-	if (leader->core.nr_members > 1)
+	if (leader->core.nr_members > 1 && !evsel__is_non_perf_event_open_pmu(leader))
 		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;

cycles and instructions are then not scheduled together, though.
Ian, is that fine, or would you rather break such groups up?  I can
send a patch either way.  (Analysis and testing done with an AI
assistant; I reproduced the crash and the EBADF.)
