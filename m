Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0312225A2C4;
	Fri, 15 Aug 2025 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293986; cv=none; b=YSgLvJMyhRNbDU1MwsFutPkOw/wmvGt+nw+YlUk2OPGrnGkm0TOWI3rg76jiCDx+TbiUvQlB8mxjojZCjnH65piBhrXOGD1mHcm2D5p4tlfNQNoc4VuQnaXtGB/L4QobZ7UJd/PxmkA6jLGmy/55wpHNQb+CYB1Gt2IBu/VScCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293986; c=relaxed/simple;
	bh=RHSgGU/H2Md4KfOMvY3PmLoZ4WtUGhjnNbXf3Vo1KWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YECuW2NCMFdy/pHFLPTvEM5BwxeqVIjqmQJGzwbk2er5G51jCDIn5Q108omMJTHwVoZnKEKpTNpGdQosf2d/n8AE523zvxDDOomC+pJr3EENyYpYCt7j44vkeYjEHrmAG1hPV6N2YkYSpokVf4H/4t3voSlST7NLV9uR+foyclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcWMctY5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcWMctY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766E1C4CEEB;
	Fri, 15 Aug 2025 21:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755293985;
	bh=RHSgGU/H2Md4KfOMvY3PmLoZ4WtUGhjnNbXf3Vo1KWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LcWMctY5bFdFnyiObAHh3RpTUuciXUOWOTB2M/Xo6pbxF65Gg9q0lwJspO/Frdcc/
	 DCnL8KtVE3tWNaFP5lasyMPGASNluN/ufhhjJewGZfKYyp0MvHO06EX7Zje5PuAjJ7
	 nt08RGfoz9uzuNG9ZBQkWq1RbpS8U1SauSSw6m3tG6sjls/jQIRaCbp04Uk9B3SG2h
	 4xRtg66Qz6KoNt967pUjLWXs+sa8u5vZDEhJ5HcFGzrpA11vCsmOM6DRciIuDuqgio
	 qbs/QaJcaclaqtL/5l1JFCi12PCvtX2tpAQgBajmqOZqoRXYOmOkGbnWR+8GO4NufF
	 H8k78ZjkWTiuw==
Date: Fri, 15 Aug 2025 16:39:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Tai Nguyen <ttnguyen@apm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: perf: Convert apm,xgene-pmu to DT schema
Message-ID: <175529362733.3232575.8797760861967373560.robh@kernel.org>
References: <20250812181422.68286-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812181422.68286-1-robh@kernel.org>


On Tue, 12 Aug 2025 13:14:20 -0500, Rob Herring (Arm) wrote:
> Convert the Applied Micro X-Gene PMU binding to DT schema format. It is
> a straightforward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/perf/apm,xgene-pmu.yaml          | 142 ++++++++++++++++++
>  .../bindings/perf/apm-xgene-pmu.txt           | 112 --------------
>  2 files changed, 142 insertions(+), 112 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/perf/apm,xgene-pmu.yaml
>  delete mode 100644 Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
> 

Also updated MAINTAINERS and applied, thanks!

