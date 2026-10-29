Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277870;
	b=opOv9juctGWbzMUnwhYW+UT0OfOeROFnwFx586VFwwhv4xL0WfsL2m65IiM8kQMNtxnD
	 9k96KamWPz8S3OWoznJoiO3P8PITlPg7H4oZ73I6ZPt/lbf7DVfuaPs7q7IU3aeE+ZjFU
	 IhpfMRkB3oE+ARA3uGJi5ZTwXjsVpc50oMCYKG1BCIoHPWH+f7FRPwC0RJd8NMr7+x+De
	 mnImr5BRARvonGKdK+GrL2L5xeCqf0Od4UVejVq0rq7Lxq/i9pBaq8EkAaOjDJsfNYers
	 2dsfRfKLOV299v5iR24Sl1sw/iYuNQE9ierGjukk4hNIL62+PFtSNvUMmyzd47r0LLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277870;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=930CPhlUxZmLoxTSew0bfBcof5ptQLgnHRyt3is3yyo=;
	b=3r1KrB2O4McHZXxSDdILDR9T2mKl19C0kvI03ghhRgWbs0ccGmSUOg1kr72q/TyEeSHB
	 tV9qzDlWjw4fDBSADJ798s9sAqbseQfmKBHDiHR1yqPVdTeOSFMyJhoJ/NvidRcJZg+8b
	 Lr/4E1hZeQ1Ygh/QHDDmOo0jQwW8FVVomghJWByFiRvsZ7o+irK99IFIJwpGexEqRzWEZ
	 uO16SFjUdmc9+b0+QTzxTqTUU22uEYOSuJFfTMCi2IPxittagIfo67OBrA0kFVH9jvMhz
	 p7PbT8gFpB81xPEkv5M3q3wrUqBWUyQ3DkY6OhTE+bI2TD51pvHIfxDXnnES58Lr21g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=BRHPx6MY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="M/a1yM68";
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3584606A31D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 12:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3584606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=BRHPx6MY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=M/a1yM68
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 285201D000F1
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 08:44:29 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 29 Oct 2026 08:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793277860;
	 x=1793364260; bh=930CPhlUxZmLoxTSew0bfBcof5ptQLgnHRyt3is3yyo=; b=
	BRHPx6MYrZp6+uJIljEzVV59ocXKK/6/AIEmiPO1GHXa1WqA6+gUleJoWzWkWeZ6
	WFu1z/DaE54YnyOYkCnCvPPnZcruzyQtjCHoBMAo2TLgIufXufgPEZK5hSmyfreO
	s+r1qwgGy9AiQvI/kei2mjhnn5VFQq44aPY9t1rgm4o8zUfcjpGwSnALjpnYk4YI
	FuLiI/o8eIgwSYeKXFQkXw+0VezJ5tjXYRoSgttwJVk413d8qlUDtxof91NUILvD
	Pvxijq5ZIZlKnTmU+k5sqJ2zZoYV5SA0U07ea/FTNCR2mu3EC6e3oQD2dB/r8kMc
	1hIlPAhUs96NLJOgKw+XVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793277860; x=
	1793364260; bh=930CPhlUxZmLoxTSew0bfBcof5ptQLgnHRyt3is3yyo=; b=M
	/a1yM68gNZc1IipSU/6VKapD4kxslNNoW19kE5tZ12Kjgh2gMwMXn+6P6Cw/SgLJ
	OLSnjTTdGxNL1l4YMuXj3GnelYCc6VfHYJIX1B8NL68yncf1kF5iIQYeHXtQ9Aim
	GLKXdb0S1dsADb2eCkbignd4c86UMnlPaZf5N4SDc1IymRo+FsADTzc2TDyC2Ehj
	P0Q/TQSIumitgdYYkQZusgYuhTSClJWvwoLlirCJ1pnXpF3cqzzdrIKuhAfu2E2G
	w9YhtCLVaOHdStB187kQzaaKhObjAhQqMcahIz2w4Mm7XYT1X3gcs02mR3ehJf1i
	B5AH+nzlE0hZRR/wKcTBw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793277860; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:CybWXGiWNKpnA17nOLKFt4GCnvNqM65GMsOi+mGEAxHifMo
	ZmBXRzN20y5R4kYrfxcT1HtoHsdMNBNs76EABuh81KDhmoeNam8aG7UiDBhmPQ8u
	/3uMpGnnJeiwIk70KHrm9kIMsgHJ6esRWJf4Rz8YZWMJBxj32djvcRU56BO33Frz
	oW6ZGXzO9EJrt1TJTgZ5gFyPnqOWETloHWeuQ+gsCwHIn/i3ZGZVBJahYt9WqbN5
	57JE73Y/NcRN3PKVScBih0rg3GtlpDDbabcv2F1bE00hSqBM1jZjKHl4gs4r/ypp
	Nu/f7dVB17QhKYHCmC1883QSmJyPAHNT/i9bTkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nEEmP5QHPTpccrQyDhujFBAY1LQ2ChGEWPSR4xvz4Vg=:ajX6q6rjV+fKBUxxT9o3Wax3YsOyxqrIFtdepkmycgM=;
X-ME-Sender: <xms:nj_jakGHb78XYpqAihYtMJx2Vd7ezbEuQGRLYTrPrHRH5rx2pv8xaw>
    <xme:nj_jaoLQe5-s5WoOI_Ces3JU6kJmhAyFWmGey8M0REk2GbMIpIAbRdBsIJlC_DWqb
    7gQDhVD3ZuX4n767ISSFfgxSjugl72McR3URV28QXuN3unJDHEUTIej>
X-ME-Proxy-Cause: dmFkZTEqIOWVDRNPpepkmsM8CkCAhRFoNZ0zH0CGJxnacnVApWiYcO9d8zAYRHt+nXvjHN
    IPDKofKvzTrz2ZwljhTOcjsz+JL/Og/68Nb2FY8umHM/a021NWqjT7thFIVQIkMjXrzTnj
    AD0YiKIasxEYFJoA0ESA1htrcUUHoAIp+u5pWvktbAHJNdZgA81QpVGaBGCTgGLLz/GgMQ
    C08ohVw054B+KHQETwqI4VKajtw4G6Gmb8xx0c1alDW7GUl6ZENXte8KbINWoU4q4vjpkW
    8QKtP4ZVWuJOY2fUVU/XQsk7HNbOj/+Ce2xOYpfWKb1jl1Uxp/AXZZo3LL6F7TenPdCWf3
    A8QRSvrSM5IysW7FODrDCd5pdkDm6uec1c9Oc6R72TG2N+2USCzuoPZGy8J7YsHCmT8ne4
    w3Ao1UlrT7TbZWd6XJNKh/0dJUrzIslkWPJshosG0xcO2P2zF5JzwpRpFZ++7FqE/c83Ns
    iGigsFa8Ad9N5PhNqjyArj6YzuL39bIYlgNadICn5NiKHskwbFjcKjfYNJ6NZzYzRKxVDT
    ENoE1c6v4yXCtN68I2U3Pt8SXKGkP9lkKnwGlI3uUzf7oC6ggLDAdVulV5eKaLWrU/gUdG
    LD+huIHq6Yq6xc2uv1XtskHJO9z7sDwvu8Jcr46aq7uq/O7HoRSSrfbA6Ybw
X-ME-Proxy: <xmx:oD_jahUqoEF6OSXDn4Cgntk1H7J8RbTqEPRbCk_DjwQ8Ct9qJO2qHw>
    <xmx:oD_jat9IPRlw_nQPVb3WDXzfknMW7i6lDpsAFcVZ0KkdytcSfReX6A>
    <xmx:oD_jah3y36AxrimeL_NhJo6CZnNacPv3gue5wJoIllsArWR2vs854Q>
    <xmx:oD_jaic50ZI30klTL6cee0FP4XN5SyO4OUSlEhoP8vi-l-FJs79Rgw>
    <xmx:pD_javR7JslPc1uCf8UcX7fofdUZ7UJUmXFkUMLdzBu8hk6Do7uIj-Rx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2C30B32A0097; Thu, 29 Oct 2026 08:44:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AI1V_CYGzgRB
Date: Thu, 29 Oct 2026 13:43:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <julian@outer-limits.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "James Clark" <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <a6ade830-864e-4768-a0f0-afc28ab7a13b@app.fastmail.com>
In-Reply-To: <20261029091736.28742-1-julian@outer-limits.org>
References: <20261029091736.28742-1-julian@outer-limits.org>
Subject: Re: [PATCH v2 0/2] Remove remaining __get_unaligned_cpu32
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 29, 2026, at 10:17, Julian Vetter wrote:
> This is the remainder of my series removing the deprecated
> __get_unaligned_cpuX() helpers. Patch 1/5 of the previous version was
> already applied as commit 50b4233a22b1 ("include/linux/jhash.h: replace
> __get_unaligned_cpu32 in jhash function"), so this version only contains
> the remaining patches, rebased onto current master.
>
> There are no users of the helpers left in the tree, so patch 1 removes
> include/linux/unaligned/packed_struct.h. Patch 2 does the same for the
> tools copy.
>
> Signed-off-by: Julian Vetter <julian@outer-limits.org>
> ---
> Changes in v2:
> - Drop patch 1/5 -> already applied
> - Squash the three tools patches (3/5, 4/5, 5/5) into one
> - Include linux/kernel.h explicitly. It was previously pulled in through
>   packed_struct.h
> - Also drop the "#pragma GCC diagnostic" in check-headers.sh. The
>   pragmas were removed in commit 10a62a0611f5 ("tools headers: Remove
>   unneeded ignoring of warnings in unaligned.h")

Looks good, I've applied this to my preliminary asm-generic tree so I
don't forget about it. I'll rebase this next week for integration
into linux-next and 7.5.

Thanks for finishing this work!

      Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/log/?h=asm-generic
