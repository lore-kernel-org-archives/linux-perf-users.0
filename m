Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989F24168E
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370999; cv=none; b=LuOYWwozwHPwKqtLeQAOGcT7QunZ5tEAPfj3H0W05bjoyk+oULheTnaijCcbuAaR3C93P9ttXSQXYBl73aiV8h5zn6sQyyujxSJRsApUd3kwpxtvN7aR6D2Xogoo3+Fi7IStWF5MQLrvEEwWQkzCad581+uPq7erTamGa+EfC7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370999; c=relaxed/simple;
	bh=ZPh0XZMAKZ/OxkHfLIzsQUuSFUMUkd8ni5QAeKu7Hdw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IM89hniJzzZZgFIWVRvobFS/oPSQeQDsVeMudzZ6OvUtcjwdDG/CFIxcczB654rKdi6ZtpcSD4YO3G9Na3ChNn44gglobohCfUcFYxWine7q/T2RlPa53ZyELmR/8/wCeHZ8Yz3/NoQ1gW7d1CaYJHI4R9tnUww1VP7c/zTmCqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV7gsipp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV7gsipp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EFCC4CED1;
	Fri,  7 Mar 2025 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741370999;
	bh=ZPh0XZMAKZ/OxkHfLIzsQUuSFUMUkd8ni5QAeKu7Hdw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NV7gsippmO62CY4BB1VbpnnOxuaaXykXe4PGo4ltAUs5sROwGVtyYuXMA6Z/EinnU
	 +rwLLZiS/q2EUMhB1zjl7PitHZPJPxmgZKMAE35aZsuQHfTBtW+R8u7E2+XozylEGP
	 s95Z6TVVI6SdfcVMPKAit/MX5FM+yPNn+dXtRaPgEYP1mM1JMq2vBF2bGI2Fg/so5/
	 brzEGBVAsaFxpxKkMjgXgZVX3RJRKlr3FZw92mSPX5QEo5VSmTzB7Mm5ehtdUUbggB
	 hPyd8EQnnqGtUDU6GfdthuoPUlCfJSgz7OXDPKxGoSzS5mpMrmFV+j0VaDNmP+duZO
	 1EtugER5gwW2g==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 irogers@google.com, Athira Rajeev <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, 
 hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com, Tejas.Manhas1@ibm.com
In-Reply-To: <20250304154114.62093-1-atrajeev@linux.ibm.com>
References: <20250304154114.62093-1-atrajeev@linux.ibm.com>
Subject: Re: [PATCH 1/2] tools/perf: Add field to annotation options to
 determine disassembler used
Message-Id: <174137099865.213280.6436963738930640408.b4-ty@kernel.org>
Date: Fri, 07 Mar 2025 10:09:58 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 04 Mar 2025 21:11:13 +0530, Athira Rajeev wrote:
> When doing "perf annotate", perf tool provides option to
> use specific disassembler like llvm/objdump/capstone. The
> order picked is to use llvm first and if that fails fallback
> to objdump ie to use PERF_DISASM_LLVM, PERF_DISASM_CAPSTONE
> and PERF_DISASM_OBJDUMP
> 
> In powerpc, when using "data type" sort keys, first preferred
> approach is to read the raw instruction from the DSO. In objdump
> is specified in "--objdump" option, it picks the symbol disassemble
> using objdump. Currently disasm_line__parse_powerpc() function
> uses length of the "line" to determine if objdump is used.
> But there are few cases, where if objdump doesn't recognise the
> instruction, the disassembled string will be empty.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


