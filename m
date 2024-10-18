Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC2200CB8;
	Fri, 18 Oct 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264810; cv=none; b=QPconRnZrq0AtYBg6AHo3jcw/Cbg+/i9DXtGHelLHwPgYd1hLMfIp/tbKRs6dJegFJStZcPm9Il3qhSW4cQal4UG7YWKiFWZkQ44ZZBsEvkG+2TfcuQmFHt/A+4iq5AT8WQBDdC+yO9Lve4v7x7g5Tq/5W+r3m8cnNwoOZPw9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264810; c=relaxed/simple;
	bh=47V7CroTEM51Vax2Va1ky10O4Tsm5SCIBrnAfESBw98=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jzw/H6vTavCdLVMy0O0472ciOpI3GScvzwTvl7Z53D4r28KL0qiBYhWn4m6lomJhZK9bILdi8kTdUnxJGi1okJ7Rqo4h8b6JlrnozEEFOjMNl6cc3XnwVLtQd2wf7ox+o90oWiIFToeoLvUumEbftOcczZyKq3zg4tzflX0R8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHYNIgLm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHYNIgLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAD3C4CEC7;
	Fri, 18 Oct 2024 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264809;
	bh=47V7CroTEM51Vax2Va1ky10O4Tsm5SCIBrnAfESBw98=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=KHYNIgLmn+xkiiCVzFwnu/gKMxArTv/CGTtF83i6mYdYlqnPnFuYn6cfPxaPUxOAZ
	 xV40gQ64DB2E0zUjWPa/idFI4RU+m3qRiSpK0pzYitFS8benzJAMdPDXhNc8FqMRbr
	 XLqmHHJlgcmP1kvdq6psWoS1T+1bID8aPxLMYLiUuPWD/mO/YLqfwpCIjkqS9ySBLw
	 TzPcE1kP+tcvoU87+ickFWC609FyvpipRnSgLVUSxDcoAUBuSsYiAGlLi0cNwk4Faz
	 r0h3ARREaWBocnZP1z22x1hgBI5MrobZJsx4QDkKi9lBwzRLR30+uSy2EZtmuZDwIa
	 Mgxez4bRB/tVQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
 "Steinar H. Gunderson" <sesse@google.com>, 
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Hemant Kumar <hemant@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20241016235622.52166-1-irogers@google.com>
References: <20241016235622.52166-1-irogers@google.com>
Subject: Re: [PATCH v2 0/2] Fix 2 memory leaks
Message-Id: <172926480907.1381973.9640137298075802668.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 08:20:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 16 Oct 2024 16:56:20 -0700, Ian Rogers wrote:

> Fix memory leaks with libcapstone and libdw that are detected by leak
> sanitizer as part of perf test.
> 
> Original v1 was here:
> https://lore.kernel.org/lkml/20240924003720.617258-1-irogers@google.com/
> 
> v2: Avoid broken free reported by Namhyung. Move build fix to
>     subsequent patch.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

