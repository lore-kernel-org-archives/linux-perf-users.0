Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E753EE1E5
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941078; cv=none; b=bR7MZMMbq732rtn+iBE64O1jRoWLSjHdfuvx2Sgl3P6FPdJpKgbkB8CqPRSmyO99NpwzmeDY5ONzVpWvIMfdP9mTk39lUyGAdsfDj2EWzJKbBjBlGRB6LWanoSr5AuZeh0z3KBatQmyrZtYfAajH26F5UWtiXC3OChDqoSFzLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941078; c=relaxed/simple;
	bh=uKh0yiFEdqwWJ6qWgSXJ1AN1P5M4nx1Aag5hldVW5ZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jf6vM/oOO09Xb3wU6nB6wt3vCIRA7tJlciIJ2M+z2hpoQxxGjdPs8xhrz0+tAfs052I2GXXIZtOlGFY06mAa9Q6qxCcKOTLmJ18At4Agileb7YoMn1iO9S+GQA0F2tAKv+fuDz9jLt4RXda3Xv704RP2Tv0XYpWTCSeL32N2RXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/C5yVtq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/C5yVtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C89C19425;
	Thu, 19 Mar 2026 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941077;
	bh=uKh0yiFEdqwWJ6qWgSXJ1AN1P5M4nx1Aag5hldVW5ZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S/C5yVtqZ368b1ZP2+3UFi0DnEsAcluqv00+e0JpckV7t61RjGOX39cbmGv8HJ9M5
	 RwTx6HOCgNyzfeLtfSa+hm69k0KKYlcm4QZVAaLtn3LIkoGWpmaooLv4m6obkYlyKh
	 n556HQXJkDm2aAzuFtw9NhfIpuPcB1XyEL6uCKShs0sqE/uuS+rrbzZMj3tFHkeE/C
	 9lUwykrcsv0Jrg4Orp1OHfI0lHIMSQiZdepjsz2AQW1779WbC0OY29vrHEVYRLWtEm
	 TFRmfDsWYDsl7f3KhFojcimY+z+rr8kE2JPVOuSQqrdCQ6KpZcFHt6u3N3U8VTTx9p
	 vKTq5v58kMoSg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, Chen Ni <nichen@iscas.ac.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org
In-Reply-To: <20260318034932.398913-1-nichen@iscas.ac.cn>
References: <20260318034932.398913-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] perf intel-tpebs: Remove duplicate include of stat.h
Message-Id: <177394107729.14914.13000590882657440518.b4-ty@b4>
Date: Thu, 19 Mar 2026 10:24:37 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-02735

On Wed, 18 Mar 2026 11:49:32 +0800, Chen Ni wrote:

> Remove duplicate inclusion of stat.h in intel-tpebs.c to clean up
> redundant code.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

