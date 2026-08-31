Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDEC4248CE
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188693; cv=none; b=fmXdVipH7aVuQrRNuiUCfioPajjf4cH1b+XS1CKQ7Ece7QCH8O9ynmK62mIG0/r9lOu9vRS9Nn2fFPt3JQPMm58eQpkC4STHuQCTR+h8R6JY2KdkdeaTFEelIojXPMg1ub3SS93/0BoG7lGkdJ1hoA1aXov+xHB0s9pvbrQlwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188693; c=relaxed/simple;
	bh=Hmo1FIZO6ymb3jI/tOkC3c3N5vu7rO4M1vmySgThybA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IQOOnL74Yniam45pGRZn3WZ52OwyJTQI9Sv0BPrmbkLaGkkFbvpLnlxnUVrju6oYpFzwgoPksp0OvblS6HjqywdQhmE5qJGtSKHJE21jDTAl3Dpbmc/RFSKRAhIuBTa5/zbxUOAtmXdvzBBi+m2lA+vJeqmNZXlThrmEW2s5TnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDNh4pZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDNh4pZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDB41F000E9;
	Mon, 31 Aug 2026 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188691;
	bh=Hmo1FIZO6ymb3jI/tOkC3c3N5vu7rO4M1vmySgThybA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDNh4pZ2olEpejitVaR+wIO+MoB0D+53S7ZVX4LhQGcL4MKsnKUswniBYsWgsu3mi
	 cS/KcDbHLpXmexGwVjc0ZbGBwLV4iL06qqTlltZkU3Bcb6zpz+f5RJW1KECTC49Tzf
	 vf1ym3nPTFk8Gzydh6G+O7AuiTeRGuOTShzzbzOCCOvI+0yLRdj0uJ4GWZrXA/GGOK
	 Kkhzb5oqDcghgsebFH6rtMKSjQ+a+XNcOszJXDaOHw5KHvx7j/RC0915QVLP7F4S5P
	 sP6kcy1IfHSMsVlWzvYgu7Neq4OFd6RYrgi4Ys4FkySX/z8jBQrEmHW0DQUmbHyp3f
	 hQlsde6vQ9ZGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] perf: Fix addr_filter_ranges lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831133314.4125787-227-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-227-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:04:50 +0000
Message-Id: <20260831150451.5DDB41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Peter Zijlstra <peterz@infradead.org>
>=20
> [ Upstream commit e62d4192e593630f355094adc467058a05bdc935 ]
>=20
> Lee Jia Jie reported that since event::addr_filter_ranges is used
> under RCU, it should be RCU freed.
>=20
> Reported-by: Lee Jia Jie <jiajie.lee@starlabs.sg>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-227-sashal@kernel.org?part=3D1

