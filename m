Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A2286A6;
	Fri, 21 Jun 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980521; cv=none; b=L+J+kXykT1YZkg+Ble3JAWL7DORiYNocYAQa+6HiTRTedhcTaBjprPwDXf4kda4kmQpyjJyOWBsjNvENpKmjReV1Qh9AyEzCP5nFE3sSGx0uoYbJ1Q4J6GVAtG+0BlFHyb2qSp17tgZX2JTtW1tAjfcW8MsHOEYR2Z6EZgX+4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980521; c=relaxed/simple;
	bh=bacV9qUz1S8RFon+sqH650IT1ishlSaDQ291gdu4JQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u50h4uy9fRYDG9CDXSBzUjmEYgthY8ah5drNrigPFrwMhvy++xe48nm8uJyh6EYXmLALv+S2+8NaFtMiq7hi247qOncHmYhBZ8Kb8G+Ma7KfbRWbOXOLKQ07tjNoX6na/O6GquaJhX9klLAlTsVi1aY2ZM25VSWBHvS5p/mVqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmXARohn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmXARohn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EB3C2BBFC;
	Fri, 21 Jun 2024 14:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718980521;
	bh=bacV9qUz1S8RFon+sqH650IT1ishlSaDQ291gdu4JQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VmXARohnjZhs6FfkbLGT2X9/8dihi2sfBpFQWgW4BDyRKFzLufeXMWFWB15SZ89n0
	 fA2aHtOAsy9HzVtn6IGgk/oSe80J6C8/h/vkueq07wAKvo5VCAVDCq6J7ZdG24mNKI
	 PLZCb6RhP2YAwT+Iqo24rR2Jm8jNuoVSd+qezkYsGMdOw/uTaPUhZOID+PAmBPB306
	 B74RBOze1WQgWDbry0MyFoL4ffcpGJNIizfsFKBRCTcJaYn7rvyhFnrAY7YfOvmiSh
	 5T6Tgc0bfpHp1B0c1KdGY7pnAR7w7FjhJrpWSZR8dp4SsyhQPFvthNxa+A3U/26/b9
	 Ja8qml6P6uMNA==
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
Subject: Re: [PATCH] tools/perf: Handle perftool-testsuite_probe testcases fail when kernel debuginfo is not present
Date: Fri, 21 Jun 2024 07:35:13 -0700
Message-ID: <171898041590.3877092.8139322744366715128.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240617122121.7484-1-atrajeev@linux.vnet.ibm.com>
References: <20240617122121.7484-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 17 Jun 2024 17:51:21 +0530, Athira Rajeev wrote:

> Running "perftool-testsuite_probe" fails as below:
> 
> 	./perf test -v "perftool-testsuite_probe"
> 	83: perftool-testsuite_probe  : FAILED
> 
> There are three fails:
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
