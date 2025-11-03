Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D331B837;
	Mon,  3 Nov 2025 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192419; cv=none; b=sz0qi+SOZ1/6xjduq2+7PoogMaJXgtGpN7z04suW71BFL6ylNEwV1FJ5rcOchdKfrx2RRsWZObYMhs75Rkndavi0BR77nmfzxAbFwwalS7sE3Z+NBDl3Q+vjUMLZirCtHx3Ohbaxbn7zzbiumcT5KU6vsdFxBk5LVMTDTbJIujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192419; c=relaxed/simple;
	bh=WKTjpwgdZc3cxdwKgcdKRaYPplrOrb0jsdB/8pSWLOk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JNAi3cZxSGrlaUbtHkpXbjG7LIAjOhZEkqrwuW8zn2/J9b3TuJQ+7KZd9VmPBofeETj04TocqEZpuffCGmtOaVec2iR1YdTxRCog+uXoZaxEoPl9tWR2q/5G2tG9yaA5IR2jCMs9XQpMrYdDqOepvdHTNnX3w+wrCmmkopqQ2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGDuCE3/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGDuCE3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E229C4CEE7;
	Mon,  3 Nov 2025 17:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192417;
	bh=WKTjpwgdZc3cxdwKgcdKRaYPplrOrb0jsdB/8pSWLOk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=gGDuCE3/Kiy3DwPOLJvENYr5wtqN+IcPpFJ2Yf+j1l/pGTPWhh07g1aMC5/UIlfF5
	 PJdU9E3xKvY8Jkk+ORovBaJZoP0bbyiWNHgSNAtObcv5I+ngHhxcRV3BthTqBwgSbu
	 ah1UWHO1tfT+J3dRfwAM4pdIn/NEpLPBrxeoT1B0jhybhgM14whgnpSFz0zforMfjl
	 n7zVxOwZ5XpLIpjDEDvc5pLwHdhdUxoHjw95AQ3bpT/k+QDyZ4FGiRv35MfDQJi4R4
	 TcX0/atI97engX0kOLDZ5Av+K6c4DKgO/XUjc3FX54uB00TM3sKQg+J75CawFS3hzf
	 w0O4Va9uBXV2w==
From: Namhyung Kim <namhyung@kernel.org>
To: john.g.garry@oracle.com, will@kernel.org, james.clark@linaro.org, 
 mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org, 
 mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chu Guangqing <chuguangqing@inspur.com>
In-Reply-To: <20251031031729.2304-1-chuguangqing@inspur.com>
References: <20251031031729.2304-1-chuguangqing@inspur.com>
Subject: Re: [PATCH] tools: Fix typo error in json file
Message-Id: <176219241594.1981113.4886974099305905411.b4-ty@kernel.org>
Date: Mon, 03 Nov 2025 09:53:35 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 31 Oct 2025 11:17:29 +0800, Chu Guangqing wrote:
> Correct instruction spelling errors.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


