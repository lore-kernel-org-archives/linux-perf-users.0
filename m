Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C460C44A41F
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940423; cv=none; b=ZamKRPvRuXNNWmeHw2zha2rXkkRNuOyGRr9TPvJcmnqHPa003Pcjerk7LVOyOlkTcG3gM1m9Upk6gncEOuA42ikp0q75wXsrC/Ik1EO7NVkJg1z0si9zguhrk6ha9q9BxlkR3CQk4+oq7bQIqHcM11StM/nw7cjnikgt3rwZbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940423; c=relaxed/simple;
	bh=a0eDyjhUIDktL5KwqLYDNyGgMyFS8f8QRC4WmatC2JE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gJh2OzQvSeeCJSGeU0TH+0wcEmX0XnZVcQ8IypDcsDQO9vzpehqk/gd9TPCvMIK0ZshyLJXSrv9EURuHVKOnI1SxH/2jz2AIhakGJEj050QzFY0hqG2KPoZpkpw0TCNphHXdWU2AMIpCemO8NKGswueRmsRDqVaNWShRyl5r1SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDsjRSH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDsjRSH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE9E1F000FF;
	Fri,  2 Oct 2026 11:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790940422;
	bh=a0eDyjhUIDktL5KwqLYDNyGgMyFS8f8QRC4WmatC2JE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fDsjRSH2gPu4YRWcotCeMzcAX2eF0c8+GRU1lzb0M5QRM3BS+jKdqzeIs5HUqlCWv
	 CHSNDo/Q2lrkoZgu4/oU9oNL3U6R97MUs8un5eJcl/6jfDF3QuRFYUqe4FGhjF/X3Z
	 21WewTdHg3N2BibqubBM6uze/eBTSf1CYk0SisDacftD+b9hE5EO7GO97+JGHLN1r3
	 ORTeSyJerI0SBZGus3AG1rtn9Xe6Cs1dmLI17P5vFGKh8eMBq/oywcE4MLo+E2y+EW
	 VH03+ej7/sunHaYQ3ZfToP/5cdYhhE3nngBM6DJldtuzGRAzl3HZe30af7KH6ZCAvo
	 2n9uIrgpk8flQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] perf cs-etm: Free partially created queues
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v3-2-1d8b6ef339c8@linaro.org>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
 <20261002-james-cs-hw_id-output-failure-v3-2-1d8b6ef339c8@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:27:01 +0000
Message-Id: <20261002112702.3EE9E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> cs_etm__create_decoders() can fail half way through and the
> err_free_queues label won't free them. Call the full queue free function
> here instead. If no decoders were created it's a nop.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-james-cs-h=
w_id-output-failure-v3-0-1d8b6ef339c8@linaro.org?part=3D2

