Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220B19D8BC;
	Fri, 14 Jun 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372732; cv=none; b=JaJ59rtt9eVEDpfhVs45gl4TRQSz0vUS62HI8g/7p+mV3FMdHBGD4VQIsdxt6sYl57jVQ/+xjEgeBG5Hm8TExvU20MoP2B973xln4YVJW/6cmsyTPcDlUezMdr39N0gN9PKEtuuW0E4gludOVI4b31v31fwes9CQrhXGbKpDBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372732; c=relaxed/simple;
	bh=mTPEu9ErEKUobSFT0GvxeIBO45KVS7yjsH7xAf+di1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xm+/1PjnzHqErdw9ATowMc7Pb7kWzAyy9yYXcSQQ6EkBE/g03FrVZFRu0EAEDSJV6dHVvcqMX72AZ1OoDHydUDAbcR3C0q+PljFqVshyERLy8niP1YMbqQePLD5k2UBVPARJepooiAKrbziMTMBhRcRguy9RFY/V403G/9Jui1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7NaJSl8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7NaJSl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9B0C2BD10;
	Fri, 14 Jun 2024 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718372731;
	bh=mTPEu9ErEKUobSFT0GvxeIBO45KVS7yjsH7xAf+di1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q7NaJSl8RUVx4k4okd0OK+YPBnvoBcBTYQ7ANwO/ZUbhxiEO2ico06v36O7tDKTn5
	 5bQAMtg9WZ0btOgWdt7kcgoJTsYQKwp5lylHmNTtQKV3xSfc31KXPP8VZRBuKVzw2i
	 ekQtfp8epdKJCj5eH5bqKuacE3DsgI7xfo5C9KrDC2zYGcyXNtuFXuesEqzN9+nbkT
	 pdTXHe0nAHKgoUqM+ORTwj7qfchvXImR4KkA6828+3ZTjXS6DmGXYxw6WAa+Wrv665
	 C7hrTBed0n8fLN0Py/ep+cWWZQYoIZi+NVl9g7RDSp3n/MmL7WFxMeX0osXhYuWMad
	 gJrx6ODIj4hlw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	irogers@google.com,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com,
	maddy@linux.ibm.com,
	kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH 1/3] tools/perf: Fix the nrcpus in perf bench futex to enable the run when all CPU's are not online
Date: Fri, 14 Jun 2024 06:45:26 -0700
Message-ID: <171837188463.3043419.6370900156954067374.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240607044354.82225-1-atrajeev@linux.vnet.ibm.com>
References: <20240607044354.82225-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 07 Jun 2024 10:13:52 +0530, Athira Rajeev wrote:

> Perf bench futex fails as below when attempted to run on
> on a powerpc system:
> 
>  ./perf bench futex all
>  Running futex/hash benchmark...
> Run summary [PID 626307]: 80 threads, each operating on 1024 [private] futexes for 10 secs.
> 
> [...]

Applied to perf-tools-next after updating the commit log a bit, thanks!

Best regards,
Namhyung
