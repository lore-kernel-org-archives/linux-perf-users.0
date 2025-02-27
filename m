Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0630D1D5AD3
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675027; cv=none; b=FJbc5aC6NHfvDdkzTFXgiJL7qBFOo7dK84jAYmiBVVDluyIf5MnZyqvrbkU6Q3WBf+DuVjybmIvnWqvTC1fUEwCEwwC3azdELQlGzyKpntPAwzziQ/dlSPR4mKjoIvBMUD/A+sEGpfn+RnDBjvcLMbGkkACrh4Id9GropLxKBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675027; c=relaxed/simple;
	bh=ozrrYtu+cfLJ1sRnT+ydPr30N8DWZmXs461xzzLHj8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kiS/bU8K6z/JotsKNgdBKxQJBmSu1xpNIzwjRu6xn8tFYetokrW7rRM/K8BlrHjmniaVASeCtij6c2O5gpNz6UIF5VO2a5Duy3o4RDNSZyiibG6/DRdhBpYgJuJR0ic0bcOq4SDWwChVc/x0GxG4WZ5nrNYAjf4UTg30eh0xeCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC6HvZqv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC6HvZqv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A263C4CEE7;
	Thu, 27 Feb 2025 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740675026;
	bh=ozrrYtu+cfLJ1sRnT+ydPr30N8DWZmXs461xzzLHj8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cC6HvZqvw4dn886MoImzK0LhAWorYFEHMqDJQdHDQ09lJ7FPUfx7sVSWWO16q3/Rn
	 SfIRKX8aeK+9EgoMn9BsYLpO58pS/wjyOyIG1ssEraOlultmtvbNGNG2OIGMm8VFq9
	 a+Wy01TRZh/XFzQRpK1kwV81SB4co4xog0FvBvOBcbmA/ZepVjLqb73A92HPmvfoOd
	 YDd4u008TOJFYKp1dnQZRPjlESHlhdbSrgRQJ9T2TxVP58bHPetS5a95+iezoG6jhq
	 V+91oas5aF8jm667rYGjXqZJ9jyTJGxyWUS/n1loDMuErOr2RtvtYB4GrcHKf3BY72
	 OTaxxtJCc3ucg==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 irogers@google.com, Athira Rajeev <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, 
 hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com, Tejas.Manhas1@ibm.com, 
 mhiramat@kernel.org
In-Reply-To: <20250225123042.37263-1-atrajeev@linux.ibm.com>
References: <20250225123042.37263-1-atrajeev@linux.ibm.com>
Subject: Re: [PATCH V2] tools/perf: Pick the correct dwarf die while adding
 probe point for a function
Message-Id: <174067502639.1401960.11262307392537559075.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 08:50:26 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 25 Feb 2025 18:00:42 +0530, Athira Rajeev wrote:
> Perf probe on vfs_fstatat fails as below on a powerpc system
> 
> ./perf probe -nf --max-probes=512 -a 'vfs_fstatat $params'
> Segmentation fault (core dumped)
> 
> This is observed while running perftool-testsuite_probe testcase.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


