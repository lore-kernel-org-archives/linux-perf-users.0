Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D9215190;
	Thu, 20 Feb 2025 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075977; cv=none; b=o5GpjTqXvOufU6BZp7SaXj/yQeWtnh5NKMsYhsr8ykB089gLM3IsaPr99RBqYGsoHelc/F+2v175AA1Mx7zLABYUyC+h+XMYn5AYjWtRlLB747yFy0aLEUr28RAS2AVXNnmkJUurnXidALadjIr/cKykZR5gzVo9UKNHW2V0b14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075977; c=relaxed/simple;
	bh=01ChFiG1KzfNKXc6RGywqJSV/PEi/Saci/D4qrSkc8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t72QpTWI1porT0AeB61qiPCGzvFwMzKxsmuoK+AZhFm4XPS65zEWC1+Tht9hqecNFHwBcjQvemRIb+f/aW/VZaANDIlpi9YD0PArjS52WZEicLR8bjAB8cWQvDTP+hKvj5w5GHpfIizVJf3Gn2XBc+IN8sEPk5xKrzIsfvMmJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtiO5ZdK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtiO5ZdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6426C4CEEA;
	Thu, 20 Feb 2025 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075975;
	bh=01ChFiG1KzfNKXc6RGywqJSV/PEi/Saci/D4qrSkc8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GtiO5ZdKbsLQ5z9TCgIj3v/JKDbv4zSLqQiwTd9DnbbBsWCcINU1CC7nfLqalE0sr
	 XQaSqWKKre5uHTeJ5iL6hZXyuMlhPKjQuLbrN3GaVtMpNC9bbUv0gbPXOwsTtJkPdW
	 QpkIQw61K6RHS8yRPQaYnUkxx0JNiBoPIAAu7bSfVKrcuGpOqs3a0v3zyOI6LzzijK
	 w78xgg8v9AARuZUrucY7Z4rHJtUZsrk3RVTbJ4A8ezZNqbqg3kBdLh4Ne+KxvAJbiz
	 vNpl68aAWVoTUZX4uREmDYekSAZCMXSU1i1GL81UUUhiG3873Eb5r9RZfXfD+vCT0s
	 CGajdHqQbVBSA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, irogers@google.com, 
 =?utf-8?q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250206113314.335376-2-krzysztof.m.lopatowski@gmail.com>
References: <20250206113314.335376-2-krzysztof.m.lopatowski@gmail.com>
Subject: Re: [PATCH] perf: Improve startup time by reducing unnecessary
 stat() calls
Message-Id: <174007597483.1790567.5712005674301381670.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 10:26:14 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 06 Feb 2025 12:33:15 +0100, Krzysztof Łopatowski wrote:
> When testing perf trace on NixOS, I noticed significant startup delays:
> - `ls`: ~2ms
> - `strace ls`: ~10ms
> - `perf trace ls`: ~550ms
> 
> Profiling showed that 51% of the time is spent reading files,
> 26% in loading BPF programs, and 11% in `newfstatat`.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


