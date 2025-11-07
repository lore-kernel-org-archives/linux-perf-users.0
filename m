Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F432E6BA
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Nov 2025 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530845; cv=none; b=nsGR48UZu2ULA61SRMmP/CYLDOVLv/6oAjZb6st8JKWIXT0H4SB/dx2QCH2Cmth2c/YvXQdriyH12wCvY2fTRkECsovThnDALcrje9ODuRKHXX4VmNbNkItQdFWZHUMNZ/EdIveu6lmp8eg0DmwSsAxFNNuoRwUVdp0wyk59U5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530845; c=relaxed/simple;
	bh=f5W0zlQImtuVz4ijpkSE3OW0/YOZZ9zWfzlQ9HOAXB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9u0Dpo5IkzzMqFWKGbTBT/ln03YBUS8S03Rh8DDc1Jis9zUqedniGD9qvMFP3WWTNlSBUpfkWyarAkxCVviqXZhpgGQGJ2A7ZwE3LWtXZONHz31c6cqiUyjKEPBBLyn5332D5Q2LMQACe5DbM5+F+vAw5/Zrro5smbNEzj42PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAzPiJEy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAzPiJEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00838C4CEF5;
	Fri,  7 Nov 2025 15:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762530844;
	bh=f5W0zlQImtuVz4ijpkSE3OW0/YOZZ9zWfzlQ9HOAXB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UAzPiJEyG3FCC8SZ9HzahNJFivkXiFHaON3c+3tp9cUB1+D/Be4mkAjUHJmn8quAp
	 UAVjjMXuLqZHVFPr6fg5rkG1N+zQ32zpcYGIOgQ00OxMBWxiY+uSALvx+K6o48SSF9
	 yfwyB+LEOJ/3QCRnBO9G0djbVbi8FmWDPn1fhaekpUFkXV/AsOTw0prVKBJDZx4AZB
	 jUP5ABlt6+5i7bWU+KZoHsphmKvsPqhLycjx7yxfED7Vu+b5WUTa2CYhsjXrOjug9S
	 LvStAC3E9DssfiHxc67kZIRx0KxSRD70YBHTVLVQfDq0yGCTI2nZCaKltHsa9YJt64
	 y5gfilGwMQ8kA==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] perf/arm-ni: Fix and optimise register offset calculation
Date: Fri,  7 Nov 2025 15:53:45 +0000
Message-Id: <176252278054.581088.13167524929157815362.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <5db610facd51b81af04b1afee53191836315b17a.1762264719.git.robin.murphy@arm.com>
References: <5db610facd51b81af04b1afee53191836315b17a.1762264719.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 04 Nov 2025 18:29:40 +0000, Robin Murphy wrote:
> LKP points out an operator precedence oversight in the new NoC S3
> support that, annoyingly, my local W=1 build didn't flag. In fixing
> that, we can also take the similarly-missed opportunity to cache the
> version check itself at event_init time.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-ni: Fix and optimise register offset calculation
      https://git.kernel.org/will/c/2d7a82480701

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
