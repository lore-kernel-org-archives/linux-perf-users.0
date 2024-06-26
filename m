Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5476AB8;
	Wed, 26 Jun 2024 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374378; cv=none; b=S2i8RZUl/0A/66rg/EYuiJ7PiKPrxbS3c6n2xuTRe5rx3OufbPsWP33ApS2xvdDJOxti5+kiqV3FM1RkntFJoJrBVDGfTEnwLdBbMp0qxRyihkk/fAem4hYO5X/RVNsjNhQ6UcpbIjETbFWoes5M5mn3f4Y7sSU2WmmPC2H/El8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374378; c=relaxed/simple;
	bh=TXH0+3PgwjhDMLPXiMG38E6IXVVKRNROwKySXMtPPQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQUUGoP7vR9UZnHZm8uoZT9BvoJE+N6VmMfSCNeELS0xlvb313ZRP0Z/za34jXRonPWd+OoKTZHI/NYJItF1ZUtVbkhJR5NdrzpCcTJPvnMseYSPB52WpTXzDnDzhtFSE61am8SGu5LaQ+lhmez4owUyQ4S3ZfbHAu792cbr8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibFOb5FH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibFOb5FH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AEBC2BD10;
	Wed, 26 Jun 2024 03:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719374377;
	bh=TXH0+3PgwjhDMLPXiMG38E6IXVVKRNROwKySXMtPPQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibFOb5FHk6jwh4bSx86XBWDEBnDibLIaiX0Dqthn1g2+hKyfAZNSGBCJW2iWmbTkC
	 3x9hrdBwmsXlqx7Gb/fLJ/wmtaxXsJv+4kInO+XHiLBlXepM8O5lqDE49ktobj2xKO
	 6lOncFGhMup6y8fmUESTQYHZN723JL0jWI6zwBtBbJjBlOPf7ENtmqBB5Ewf55Wf8m
	 XOORnNeP1zzBwyHpUVimNqI8zSaDUR2Ie8Qq1JEXm6+8v9FJ/P6ZEjK/no2ZBT+7eE
	 3xmvvADmb3RtgAwS/yJa+80AZl5B60eQO2OQptcNyEsowYLK92glmstgaw5eys44kU
	 CodRPw/AZgj/Q==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: (subset) [PATCH 00/10] perf intel pt: Update instruction decoder for APX and other new instructions
Date: Tue, 25 Jun 2024 20:59:34 -0700
Message-ID: <171937428317.2859368.15702717224833851505.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240502105853.5338-1-adrian.hunter@intel.com>
References: <20240502105853.5338-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 02 May 2024 13:58:43 +0300, Adrian Hunter wrote:

> The x86 instruction decoder is used not only for decoding kernel
> instructions. It is also used by perf uprobes (user space probes) and by
> perf tools Intel Processor Trace decoding. Consequently, it needs to
> support instructions executed by user space also.
> 
> It should be noted that there are 2 copies of the instruction decoder.
> One for the kernel and one for tools, which is a policy to prevent
> changes from breaking builds.
> 
> [...]

Applied patch 9 and 10 to perf-tools-next, thanks!

Best regards,
Namhyung
