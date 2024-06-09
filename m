Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEC64C79;
	Sun,  9 Jun 2024 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717900453; cv=none; b=Fwodh5BRIcfwGj17OohA59m38nd+Oomzn21t0eaqko82owwmEx932cNjnwDMtIze5J6GKgMfHyHLwy/pESaXcafnTl9KGUTfKkTmNdqqiB3x9lcRIDFsEuGR2MSRaxaIpvDP2HgGD9GEjj1OhWMX7JdtOcYrGq61dAVcAVzbGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717900453; c=relaxed/simple;
	bh=jTuMu3d9qHNEnNtGsp4N7GknpMOck0u9bB/n2Uj/4Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpxUaDwV57YfseX8qVaMptbYYGtjo7biCpiLttNjP4Kbf172J1jTiz2cjSDVh+K8Ni5QhGkcacWdvBln4lU+midVEkEQFQ3ch+k1GKoIPCTViMhmpUBKdRF+c6DrVvUKkOmA0c6q+nPLM3PmRRQ7L5mhxsRNkBDvqWqTb9sCV/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a435ZTPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a435ZTPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA241C2BD11;
	Sun,  9 Jun 2024 02:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717900453;
	bh=jTuMu3d9qHNEnNtGsp4N7GknpMOck0u9bB/n2Uj/4Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a435ZTPwisgFfuNrgdEt1/tQb76VyOWaNCgscfScVmQnCQAOiA9MKE4MH/8KtjIxQ
	 ei//9mWzyhUKEIimGHrdMAOv3Wa7ln7zbEGOdkBS7usOM0qU0nDm5WppNmiBuRQ6Uq
	 RbQNpe13TK5jRCwMFjEAOaxI3uANOO563qfM+z9jFcXCH1HwL8UIC4KIADQCuqI03B
	 QHHZO+frt8QLwqo/IByR9S7sbE8g5G34/LaoX/SdDWeCaP6wlXPELQ09+pVIx0WvLm
	 6k8ewB9qpOAzkuGPOOOM4QhQKmZBr2MSSxAnYtQvn3LqocxcpPXRO6/+4u8879uAls
	 +53dJEtIXl0wQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>
Cc: svens@linux.ibm.com,
	gor@linux.ibm.com,
	sumanthk@linux.ibm.com,
	hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Speed up test case 70 annotate basic tests
Date: Sat,  8 Jun 2024 19:34:11 -0700
Message-ID: <171790043890.3969730.1328402717914225319.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240607054352.2774936-1-tmricht@linux.ibm.com>
References: <20240607054352.2774936-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 07 Jun 2024 07:43:52 +0200, Thomas Richter wrote:

> On some s390 linux machine (mostly older models) and with debug
> packages installed, the test case 'perf annotate basic tests' runs
> for some longer time.
> Speed up the test and save the output of command perf annotate
> in a temporary file. This is used to perform pattern matching via
> grep command. This saves on invocation of perf annotate which
> runs for some time.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
