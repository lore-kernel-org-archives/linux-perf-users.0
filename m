Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C987A723
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Feb 2024 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907534; cv=none; b=UcsdT+Hvecwo+NLhJ6AlVH0z45ZFgnT9dJaNMnebaCgVCPEvjDwfKDL2mvmX+yVUxx34k8GJ5eBGTTr+IWlsg4dS2GzauS4I0r+wD/Lhhzh6PC7NmHQsaGauIumnteR/QgKvU1U1fHxo1vGPGsHXxc2/W1ThQt+SgSrxxGXJsL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907534; c=relaxed/simple;
	bh=MObcJakYjjihlzWnI2kLZsQGuOkmTUAsryJ3NHCtYe4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjnpsfgRdlC9/jv1YWpi2j0Cfedhl+4+6gtcmGSWWpZI9/vXi90uHIrlkKTrFNvtfBryhHkEt8B914KWqHK9BEvMlOpWOWUwD9MgHVt4AAftO7r3SbJQU07JSb+GW5BN1fgvWtlD6CrnFuIJKsRF/pUWtjTcFCceeYneRRxphIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQyseDNs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQyseDNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41100C433C7;
	Fri,  2 Feb 2024 20:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907534;
	bh=MObcJakYjjihlzWnI2kLZsQGuOkmTUAsryJ3NHCtYe4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mQyseDNsoo1LVO/0vurFtc4N+upvdy2CLMge8UU2XIzE1frWH0laUPUbryaM5iQ3p
	 nS9PmlGB6d93OI3RodiXCGDvV5KZFmxYm7YOBj5b9Ok/FFlNPsJV/L06VGVHO4CQQ9
	 c2w+paE80lwzelgcQ9hBcjoZU0jTPJuNBRDrP15FX1U//jY5b7xzQDkdDg1nkYg1Y1
	 ZCjLt2wIf1AVKqdW41xaMHSgWFHcUu/s/tzv+E0EDyLkqoVYUEKjByVDsQI37uvPRE
	 vZvkSQSJfuejbNQDAqFb1eCHvlU46obzH2y3EOFk6EylT74Le4l4M6sTl225gE7PmT
	 gXjltKm33aO5Q==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] perf Documentation: Add some more hints to tips.txt
Date: Fri,  2 Feb 2024 12:58:52 -0800
Message-ID: <170690725035.1264496.15045486898282635274.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240131021352.151440-1-ak@linux.intel.com>
References: <20240131021352.151440-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 30 Jan 2024 18:13:52 -0800, Andi Kleen wrote:
> Add some (hopefully useful) hints to tips.txt
> Also some minor corrections.
> 
> Would probably good to make it a reviewer rule that if generally useful
> options are added the patch must add an example to tips.txt
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>
