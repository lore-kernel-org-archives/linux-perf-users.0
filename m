Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D21F239D;
	Wed, 11 Dec 2024 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956335; cv=none; b=bh2W+34K9Dpyma5lY0pKYcsxWsbjzrJJDljKjUL6dS4RoAFpOu2tvw4TUbhoHscmPyyHc1pKWk3e1I4GtPZuOSn1vQnUFuWpUwXkyqRN8rAp8bW0HNBK3hK2TLw1RlhVKd5M0/0FHNbvAHS30kJt8IKzHIR3Xhp++WflxsspUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956335; c=relaxed/simple;
	bh=H8GLjR52AOObBuTGRF97jUFOPtYaGcj14R3/x3FDoxo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WQaixqCRXyclamAMvvwLAgETx/Zs9mlDQjYOarMz3DykbibZC6rywUJOGu3n+4KXwJsD9NjaiuZqYtIbCjAUyMfRERoSzAuPcECpVVC/YomLgrhYjPzsxtavwkEBOspED5sbUGyS/DQeQZo0NNZDLWsRmz/zewSuHDFVZ3Rg26Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmF1fS0z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmF1fS0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AA3C4CED2;
	Wed, 11 Dec 2024 22:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956334;
	bh=H8GLjR52AOObBuTGRF97jUFOPtYaGcj14R3/x3FDoxo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lmF1fS0zHS+wP2mJFmAvBAT0uY006ohKN/qRAdUT3w17Jl2nhVTsKlFEbNZip+aER
	 BFU//jH27hu2mcsj5VlcxQDRcusC9jwZB8GxY+Ncjs8mHLjLTwEa+u2pQKz98uvCz+
	 +V1ILKanbZ1h3ZH6t0mNGKaaur3anEyK7cjG0EBkcx3F+AKPNgPg3nwMBQwPZ3DyF3
	 2yQ0/Vcs0ov6Kjt3XXx3hjacpMOZhtkv4Y8Sy+WwwcD543RecaQKzzZkHd2aiEhf75
	 blJ0BtUiDFW8KFswUcm8yNqx+6Wm8xXzQSxIsusD7Iv2m38B0ghf1VD0zOG4FJtAvU
	 o144tp4L+hcIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD74380A965;
	Wed, 11 Dec 2024 22:32:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/20] Remove PERF_HAVE_DWARF_REGS
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395635051.1729195.13191557882673334015.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:30 +0000
References: <20241108234606.429459-1-irogers@google.com>
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-riscv@lists.infradead.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, john.g.garry@oracle.com,
 will@kernel.org, james.clark@linaro.org, mike.leach@linaro.org,
 leo.yan@linux.dev, guoren@kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, terrelln@fb.com,
 mhiramat@kernel.org, changbin.du@huawei.com, amadio@gentoo.org,
 yangjihong@bytedance.com, adityag@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
 masahiroy@kernel.org, maobibo@loongson.cn, chenhuacai@kernel.org,
 kjain@linux.ibm.com, atishp@rivosinc.com, liangshenlin@eswincomputing.com,
 anup@brainfault.org, oliver.upton@linux.dev, sesse@google.com,
 linux@treblig.org, cp0613@linux.alibaba.com, dima@secretsauce.net,
 przemyslaw.kitszel@intel.com, davem@davemloft.net,
 aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Namhyung Kim <namhyung@kernel.org>:

On Fri,  8 Nov 2024 15:45:45 -0800 you wrote:
> These changes were originally on top of:
> https://lore.kernel.org/lkml/20241017001354.56973-1-irogers@google.com/
> 
> Prior to these patches PERF_HAVE_DWARF_REGS indicated the presence of
> dwarf-regs.c in the arch directory. dwarf-regs.c provided upto 4
> functions:
> 
> [...]

Here is the summary with links:
  - [v4,01/20] perf bpf-prologue: Remove unused file
    https://git.kernel.org/riscv/c/2bf7692eadc5
  - [v4,02/20] perf dwarf-regs: Remove PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
    https://git.kernel.org/riscv/c/6ac75289b288
  - [v4,03/20] perf dwarf-regs: Add EM_HOST and EF_HOST defines
    https://git.kernel.org/riscv/c/ae894b77923e
  - [v4,04/20] perf disasm: Add e_machine/e_flags to struct arch
    https://git.kernel.org/riscv/c/cd6c9dca9d4b
  - [v4,05/20] perf dwarf-regs: Pass accurate disassembly machine to get_dwarf_regnum
    https://git.kernel.org/riscv/c/9fc4489a16f4
  - [v4,06/20] perf dwarf-regs: Pass ELF flags to get_dwarf_regstr
    https://git.kernel.org/riscv/c/a784847c2da1
  - [v4,07/20] perf dwarf-regs: Move x86 dwarf-regs out of arch
    https://git.kernel.org/riscv/c/bf4e799a0a33
  - [v4,08/20] perf arm64: Remove dwarf-regs.c
    https://git.kernel.org/riscv/c/6f8e8add5a0a
  - [v4,09/20] perf arm: Remove dwarf-regs.c
    https://git.kernel.org/riscv/c/0c0a20ecdf67
  - [v4,10/20] perf dwarf-regs: Move csky dwarf-regs out of arch
    https://git.kernel.org/riscv/c/d4a0c4f22121
  - [v4,11/20] perf loongarch: Remove dwarf-regs.c
    https://git.kernel.org/riscv/c/1d37bd8366d8
  - [v4,12/20] perf mips: Remove dwarf-regs.c
    https://git.kernel.org/riscv/c/8a768a2f6592
  - [v4,13/20] perf dwarf-regs: Move powerpc dwarf-regs out of arch
    https://git.kernel.org/riscv/c/285b523c2da2
  - [v4,14/20] perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h
    https://git.kernel.org/riscv/c/a90c4519186d
  - [v4,15/20] perf s390: Remove dwarf-regs.c
    https://git.kernel.org/riscv/c/b232b704a781
  - [v4,16/20] perf sh: Remove dwarf-regs.c
    https://git.kernel.org/riscv/c/04150f29e212
  - [v4,17/20] perf sparc: Remove dwarf-regs.c
    https://git.kernel.org/riscv/c/85567a2a8d42
  - [v4,18/20] perf xtensa: Remove dwarf-regs.c
    https://git.kernel.org/riscv/c/a4747c09507d
  - [v4,19/20] perf dwarf-regs: Remove get_arch_regstr code
    https://git.kernel.org/riscv/c/3ef6b89a129a
  - [v4,20/20] perf build: Remove PERF_HAVE_DWARF_REGS
    https://git.kernel.org/riscv/c/ddbfb6f20c1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


