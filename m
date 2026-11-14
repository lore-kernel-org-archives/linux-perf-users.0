Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794628977;
	b=WS16vRNETG2tlSGMCGDWQrLBLA438sWa89ozd2jjprGL8LBFhr6wxtaqZOHIiD16X5+e
	 diDHsE/TjPrqM5k8qwi5N41QgcMC+gkZou4vQXbomwKWik1QtdAIteaPeibxO1E3Artzm
	 ohzuM4ODb2cz/XIJ35D/b7PM2mCzIRzDHN0IBSDq2MK/8p8Ea6kMxaR6zLKKNOCbnIwiR
	 k90LqZ+4koeTB7/imVzfM8JGCyWkVjIhZmXN0XhehkJi9y5E8lsera+A8PUnk0N8r8VwG
	 3ZeGcEv536d7QGKwZfX7PW7TbjBviyTSFLIZbVanRqSOFC4kjggvJRjaN7kHdZai2Ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=W9WNFigqzkV9FnCsVdto3Z6IgdKxkYLfEPiIfIJ8sVA=;
	b=v5kfJVnSvBjbcXD7RmHe/kOLCdCYdLnLiUS3iXMoGH6aIOxm3TYtX9bb8wEpeUg73KyM
	 hvt/k5ya9arV97EhoDgmsV0CkdmqgU6raYWm/WbQM0K09h7fzsCx2XxRxfFb/lhhTiMeD
	 /EBT2frzrRpKT1HKTOXe+ASqYvS4OQdco/xjHcmbvf/QknNTocb6VYXC11cP+3i/KZDy1
	 elr+MjaDxHP1yjomYRgRS9+Dmlr+HnQe6y0GdgZjhp8aBqR9FJaN/Icqb+A+7BXcmrXF/
	 BP7C+/GNLkmxy8JYK+ebEE+vrt5/aPftDG9cLYHFyPAduWhX1vP2tPcnLiom7z5VgzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=fHsUeXZn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126C606A329
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 04:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B126C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=fHsUeXZn
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b335eeb340so15777187b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:02:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794628976; cv=none;
        d=google.com; s=arc-20260327;
        b=SeTpi2DTooIsjcSxHdmyghwpne0JIrRq/zlfQm6q0Dp6GfojADEq367PUFJd+5PiSB
         G6bvgCOJgnIC74q7h9AWJaGTgHKDA3hx+ErlXVzuho+4xFDGEqlXY85lsSOP25s6GpF1
         ydmfvALAjN6C39yHP7Cu/Oak9ZZ8/bFPiuf6U8eVpKHg3jNCahYR1x8WAfQ7VrURcwoA
         ydHPj5JRb8UnaYpTGVXHIEVitshpgUu3CarEjQFaHPtfA9IWZ1N/YNk+2gElnS9pCSHT
         tNFNdncpxmZ6Rji5q+GOe1EKJMSqOns02+Ztl+NZ4d0FPJf31cFAdv4yskYBBcjVNCTL
         sBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W9WNFigqzkV9FnCsVdto3Z6IgdKxkYLfEPiIfIJ8sVA=;
        fh=hMbHO2+mABXbLfrrCfTCtcnGHgL/EeV37n5+Al6pa8A=;
        b=pjpNoUq2v1S1h96zBGTcr2K+wQEXLxWVOIaHz+cXAIG6zg88t5w+1HoatNG8prE+g0
         WXzzGUnan4XYwO3wlkQ716BlRhTPaJyYCMidcKY2X0za9auPvJLzdoSnsIV2lBIzlniZ
         zqKAsQ3RIbHj0bmspPauILrTaLrXmxXmtpORvlskO4G9MfU3ftnOHKChCKoAxJrswhdF
         vNpiMgA/qyDuguu406BiARHREyN9w9VvpjAhgHbp8c78zW5RSs3Qjuu9uRuSN7OeLZWf
         etjNxXFIscUen58etGdXh53vmyXbfiR/hr/8VJz8ZTkZf1bw9AbT26nmkRw+BoIB9kHa
         CioA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1794628976; x=1795233776; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W9WNFigqzkV9FnCsVdto3Z6IgdKxkYLfEPiIfIJ8sVA=;
        b=fHsUeXZnHPDRtRlVQYn/MFXVNU63/4kunf02166D2iVIyqiYz/jWQ0r7SzVbC8HoP2
         HxE0KuAhOyEoHqzPre+lGYN+q4j33de592Wnt84l4gEPSu6v0H5pvoeKKTwopQxz1OsO
         VZqHETHM8u9JZLw4cZBKGXyloZFsNG6M7xPOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794628976; x=1795233776;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W9WNFigqzkV9FnCsVdto3Z6IgdKxkYLfEPiIfIJ8sVA=;
        b=zCSsjOo5YawwiAifMkW3IT4iEgw6ui1RFhta0CEHQPb1PX8hUUzlRn/4yGkgBIC1N1
         Y2aXC6amFmx4TRFiT0FAd8xveX31DaC+8XvHTTZCTB5l7ItWQvsZwbV+pIxDxGew+ELv
         lka5r0JXsC6Wan432IQXtDi/W+yUC9hXkshqNiVmQ/fOFlx+0srRUf/0v9yAYErrmf5R
         UGaZgdEM0eO75yM8c3Dq2lZVIAl9nTzHTUcIlkzKVWqM4OEv4seI0+QUpqwjTD47+Nyi
         2Pv8LVhOshAmBwW0pyew1IJnXPp7WwfHdwDuV6k3mVpVVUgM0YpAnAepfN7LcYMugtqU
         f+MQ==
X-Forwarded-Encrypted: i=1; AL+hErHYp74kPNQjdC31bEuORHS6ZISuRf4vKczoVNwRaRGKdMmvY7tFjLV4tjMuP/2M80P06xCz5fX36jomSGVEv+Y3@vger.kernel.org
X-Gm-Message-State: APuU4Z+objIn/WO4O9dk/8OfBoGqH4MN/7DtT84HMayrH1HTtN+roYYx
	iq8EFgMh/x9uXMhapb83a12eEDYkJCHFDwMI5/LGVu+tU1jJD57y8hnhiDmDYcIgtimQHKgvd1O
	WtIXGwsJmc4Shw8/0CrGXXTeb7Mu7j0nuOcw8q4Mmlg==
X-Gm-Gg: AYBFou1EExolEzZQofg+xX2RD4bbbXGRC2mlH1BUuGZlQWAWcRrJ0QCrfuUqktP/M0B
	N68rvimQ1qNtB2zYzzVuzuB3tlmfFqb15PPBdQqvapUqFk1AfWzGz+GU4Y/0pEyskeQml4RlfyU
	oWpLsa42Ll46nzkayugAPYQUto3EkwAsndTvGZ40OA91YR3PA44l8diMwqUyyQUUEYsjS4mWPr4
	X+23aCnCgCK1Wy2+to8ydtOj9T3pALIAdt3g2soQLmYZB+X79r1TBTlwVUp1ggpmhBbrcM5zSwr
	lK0MQ7kLPLfQBLhLzzYtHQLHpljFqG10TQXpgWSGRJ0Wp4xc4lL/mFUtKpZM857RVOU93yugrhN
	6JZzZjhha+dyqrjd7tU7sKRYPL1TRKNaTbIetERgK6icfLkF4Ci+jVMunrf0WfvmhHVFiTQ==
X-Received: by 2002:a05:690c:a923:20b0:8ae:8021:568b with SMTP id
 00721157ae682-8b4aa2773aamr19777537b3.55.1794628975427; Fri, 13 Nov 2026
 20:02:55 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
 <20261028-perf-symbol-memory-send-v6-3-7e90415f0101@uber.com> <CAP-5=fUejV8+M10Z-CtqnOS1qdkoemJ=3GWWQyfw0TAHQps7Og@mail.gmail.com>
In-Reply-To: <CAP-5=fUejV8+M10Z-CtqnOS1qdkoemJ=3GWWQyfw0TAHQps7Og@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 13 Nov 2026 20:02:39 -0800
X-Gm-Features: AclHuK90CRBSEEI5lhz82UiASPlj7VnM7e5-U9MNuN-a0OTVdZlfiBYCipVjUWo
Message-ID: <CA+w=M=Rru+ZPHAc7xGnj5kNM7M1A4sji6+TsL=S5kztjWtjdCg@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] perf symbols: Point to the symbol name instead of
 embedding it
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 30, 2026 at 8:34 AM Ian Rogers <irogers@google.com> wrote:
>
> I think it is a little worse as we'll need 3 bytes of padding. You
> could reduce the padding by moving name to before namelen in the
> struct.

Sorry for the late reply, I held it until v7 was ready. Thanks for the
review. I checked the layout with offsetof() on x86_64.
Before this patch, sizeof(struct symbol) is 48 with name[] at offset
45, and the allocation is sizeof + namelen, so those 3 tail bytes were
already allocated and unused. With this patch, arch_sym is at 44, the
name pointer at 48 and sizeof is 56, and an eager name is stored right
after the struct. That is 8 bytes more per eager symbol, not 11.

Moving name before namelen keeps sizeof at 56, because the struct then
ends with namelen, flags and arch_sym at 48..52 and pads to 56. The 3
bytes would only help if the eager name were stored at
offsetof(arch_sym) + 1 and the allocation sized from that, with
symbol__delete() changed to match. Lazy symbols stay at sizeof either
way. I would rather keep this patch simple, so v7 leaves the order as
is.

> This change makes sense to me. I'm wondering if any other things
> should be cleaned up with this change? For example, namelen is only
> referenced in about 8 places and we may be able to replace it with
> `strlen(name)`.

Yes. namelen is set in symbol.c and read for column widths in hist.c,
in srcline.c and in data-convert-json.c. Dropping it saves 2 bytes, but
not sizeof on its own. I can send that as a follow-up after this series.

Thanks,
Alireza
