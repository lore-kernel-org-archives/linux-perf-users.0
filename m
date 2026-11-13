Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614325;
	b=5i2ODZW5UVpUjil5ibZ0pS7nj00iGwXfvu6HvsoIYzLJMpWuA+t+j2HH9FvCQ+ubJuab
	 +ogI/3H1hZdQ4CJzD+Z+fHpFdZu0BeHCSIi2b8CbqZyQVBmaWOMoBdnItRtEygKaSzT0L
	 RDcwO+GNG0DYYH2VBg3OBO9ItaS04qc0nlRbeKgiwZXazrpwgXh0u8xz5uL5/1+HaCWZz
	 3fHeTWdKfDv2M7vxqav992SNZ3WwWG1vXsUiy1WBalcKunSBKzdVqOnGTgi4qDUSKzx5P
	 ay/SgpqaliXL+Pp7wCmr3g3o8OfAg1J/hC/F/L7flkEYIzjUslguVOjwAvV0KD0SZlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=n/DGsb4Q4UQJAUdjwRmLwDE8lUxnn6ZgFmpe2GZ5h9I=;
	b=AkaKHA8WL48M2YXldl7sINbPNcJUxRzKazf7608W5M41hJ2eDreHozHR/VlDxlyB9Eld
	 evUObEwoehp8bwytBZ9x61OtHa8EmobnWjfUXkbw3GGZ11sYVzCbdBJe6uRvyxfFLFkRI
	 gMXCwpgA3dveIFa5+YI7TiFC7J0PB1kLajGqO9ptrNHVm1wKXE1p9+uP1ZQsNs3ISo/Dh
	 LCw8hKF/r/e42u3g5kL8V+cScyMxNvPdStM0qJV0qPYut1/b32SMFzhpl2+wk+yYL3R+n
	 e/sgG42PXR8c/ye/Ipl6Zxwru0cuAdn7qWU5hJq+UHZxjLrseM1eMlSvH0Yn1J4L5yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=larqWjJS;
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490BF606A89A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 490BF606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=larqWjJS
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-679a2b5fe87so1802678d50.3
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614324; x=1795219124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n/DGsb4Q4UQJAUdjwRmLwDE8lUxnn6ZgFmpe2GZ5h9I=;
        b=larqWjJSglw1WgxLVg6fCbke/Es+wTZfPspGID0y2pFG0aOQ8y5VCehHOkP51MP+2z
         sEITXV3nZya4uweQjw7fCZVHa66kZXArsfb2BHwlSsOQpE5y6Jfc7suNWObrJJ4P15Ah
         6Mwf87Ts24bKSgRbwilkfl+vY49QF3rSgh2Uc5wZpH9JjLic4BaMEfBEEolCKPuOEuuP
         AocufNuX+lNBbguaAuf/iyIwSaDm9VYcy0xosATiRSugt05wRzed81Tbb4dpvW3Z1D/9
         3+JCGAgyIBlCOyHNMm+zfxjptjtj+mV/A6J/ICBJ+JdB9nW4/UiKD3i4XnEA34nKbX9p
         rZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614324; x=1795219124;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n/DGsb4Q4UQJAUdjwRmLwDE8lUxnn6ZgFmpe2GZ5h9I=;
        b=HdnnSSvYexErgMykWzBb4gk+QEPZni/owgjww2XcB02dh7Vd0EY7lw0+wPSm25+5Lg
         JIzMHagSabHBqI4Y9ezN6n/LttI5dQ5D7zNpHsLkJpl30Ux3ZZtqIvQtEn0xk4r84vpe
         dd1mX1/UuAbp7if47e5rFkkFepVnrm3fRQyB1XIektxuvZ78oMrF78O2YBXK2XN6duep
         VR/vDJwiXDndM4D7m8b3G7aHV1Fl0i/sred0wBHywiHbei4rapxwOKT906RneKX4e6+o
         8b/BBnh2ByksdJ3RHkVjSiLU2bC+OmGoKX8D4Q5UViW3grUso2tTvdVZCLVlsLX/Quz9
         3H1w==
X-Forwarded-Encrypted: i=1; AL+hErF8PdWnvnerfChuJzfYbegsspELbxoWEO7wq1ZyJFfIyvGRbcydxBpgyAVf+rkr5VestOD+Ae3Z5ck+P6EemqoD@vger.kernel.org
X-Gm-Message-State: APuU4Z96AiPOc4mmeBISC918GOYM+cvJ//nWANUcFBtmFlisvOY0tOJp
	2K3b+ZuDtPzTRvA1BiX8AtVzoUWqy4uP1vc3SqXrxkqdPcg8JNU6GTRt
X-Gm-Gg: AYBFou0yC/SWY0jIu1Rn/GUbVpMMzcqkMnQ3KbVu48pcCuxCA83rJ/g4ORG+2ONi1fy
	ksVxMlenxXWCfpSLWkhOiZnHU9x8G77aTIcbn/hwlpcEG/Y3vOUxoEmAcLhrFB8GvQYkYQnqgkj
	/e3MdQGjyUtJVSui/3CW3qkpxhOesOQOaC57A6yt844M7ypMX19D55/isw/dxZI88RcC0f5taAg
	JKwgs0ZTqu2m9gjj8ooS8PtQROODknBN4cHhrnnT6zwEsDI2j0RQvTIaC7T5rSBwY8nP2Ghpqgr
	GFiQD8TlRUyeF5wbsG4fnoZAXUEbHt2kQQt92jNbzOsbM8/eJGRsK6YjjQynhd2KHANPFPliy0d
	cigHeqctzMg3zlYMLb1RZhbYGMTziXibh2s0hqkiE7emR4YSz4BYgQaX2V8y2RedvP7u6rJs53Y
	OwxoG82nCN3H9ybtJa0z5eEDSynKAA9Lls2et47vhp94WTJegheOcbXfGxrle9PIWFW4dGzSdHO
	4CZHDhYf/tmEqHk+lu6gY/Wy5l3jyI0LLXo1hcid9RUFeSEZZAtp61v9j/t+a0MJKTZwAFPR8LL
	MVg/sEbv3VVo+pUejnHTqCpv0RdmMB4XosujoOsw0Y8p0g==
X-Received: by 2002:a05:690e:13cc:b0:67c:56a:f173 with SMTP id 956f58d0204a3-67d897bb534mr1772721d50.160.1794614324075;
        Fri, 13 Nov 2026 15:58:44 -0800 (PST)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:c9b7:cb5f:2bf4:1b2e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a555c15sm3462796d50.8.2026.11.13.15.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 15:58:43 -0800 (PST)
Date: Fri, 13 Nov 2026 20:58:38 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/11=5D_perf_coverage=3A_A_h?=
 =?US-ASCII?Q?arness_for_perf=2C_and_the_fixes_it_found?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAP-5=fV1FRJcyCHg7vNjptZU996PBXcEcve5m3sYkUtdWSmT8w@mail.gmail.com>
References: <20261113200850.2803460-1-acme@kernel.org> <CAP-5=fV1FRJcyCHg7vNjptZU996PBXcEcve5m3sYkUtdWSmT8w@mail.gmail.com>
Message-ID: <DEB65601-1A5C-4585-894E-EDF6B99BC8B6@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 13, 2026 7:16:05 PM GMT-03:00, Ian Rogers <irogers@google=2Eco=
m> wrote:

>Thanks for working on this! Patches 2, 3 and 5 add small C programs
>compiled in a shell test=2E These are a pain for our CI framework; could
>we add them as perf test workloads?


Sure, will do in V3=2E

- Arnaldo 
