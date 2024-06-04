Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760A112DDAF;
	Tue,  4 Jun 2024 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539352; cv=none; b=dWYEPB7XtgMQUvkEB8/VberqIXBc2OSm/FCRcg4VOUPF3voJ5eQSiO+wPYvvIEfbXEuS+gQMufVGhRZd/QmY5AoNFhEHazme5fBJJJhemA5+izxRedNw3x8WQMfITwlXyXpa+Uuq1gBGoKG/1TVScsYDKLBQNJlklzxakKK2Tyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539352; c=relaxed/simple;
	bh=iZW6YpDkzpkxInUekuXZfAXDyGCYo2ARmph2bL0deDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZLn+7GgexX9S5w5yWKhuC/7Ld3tTAcHVj+FMB6qJzzSn+INVLCaWKQxhyyw3cu73Z5stGIS4dM66OgYA5qrP50argOYUxD/ri5iG4zUlQzZr6ZtXFhgP6TN+wEcR3/FztnaRH+4up1G3vMDKyUFCRI51PDRA+Jksca02A8Jos0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq8U3ZN/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq8U3ZN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F7CC2BBFC;
	Tue,  4 Jun 2024 22:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539352;
	bh=iZW6YpDkzpkxInUekuXZfAXDyGCYo2ARmph2bL0deDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pq8U3ZN/0MdMI4wezF67U+WUH0RAHjvBxEPOJh2xsYsVcym0MqSU4rEFmb2iz1Zu5
	 9Yt97rPr1yIS0citcbrFkTmenVlNAnb1Dxvg6gbv5Rly6rWDO+ARzPV2kRfcA5Lbgx
	 iaz1u6rbkyExT0b4HCTJHvJJZfZCe8iPKUSIpE8tEyMVoPXE3AHl6HyGYjutEn+TQn
	 hSPACSjrbhMacxPWDD+Qf39AZh82qpCfscsU6AQJamtHe2DlnxzJPR6Z3+5FCLzZ/h
	 u81VVg8P0DVehXuLn2gos34wKww4HKjgr6ZDRukpyNecLlRANjH5kkcOwtH3WE7Zt9
	 AytnXfxffnDEg==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com,
	peterz@infradead.org,
	jolsa@kernel.org,
	mingo@redhat.com,
	linux@treblig.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf genelf: remove unused struct 'options'
Date: Tue,  4 Jun 2024 15:15:46 -0700
Message-ID: <171753931319.954236.15553005337699985549.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240602000505.213032-1-linux@treblig.org>
References: <20240602000505.213032-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 2 Jun 2024 01:05:05 +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'options' has been unused since
> commit fa7f7e735495 ("perf jit: Move test functionality in to a test").
> 
> Remove it.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>
