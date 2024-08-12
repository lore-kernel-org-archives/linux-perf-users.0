Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A114E613D;
	Mon, 12 Aug 2024 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495583; cv=none; b=cJSKAby+YaOd/FJxv9wQ16B6/QNDeW6y29TQQDLwI/uu7Hs3FLid8zk5mIbRcCGZYFE1OyYxvwy7r9urd8AYyGbQPGqxMWtJUPug24DvIE4tLZ8gp3ZpFBqsu6MNqWxqrvpJenOuZ/Npd447P/1w3bVW9Vy66rUGlJoOrV6z06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495583; c=relaxed/simple;
	bh=BFoX/qrFoQp39Oml7ZScH5DCyVCYHo4zgqWnP4mlhkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx+hZDB77Rln1liBslA5DizIUo7h53DKixnfO6YbWAVEsOc+e9LWP+QWNLii2wkuMRm4CZMACGF2rnB2kF2dPwas9xLwXWFypWbylF2PhynMB7Fz31vBb6HjVpZIhmMSwI3/L7puRVgLEsmZvwQaL9RFbkXr5x06riBbCAa0E9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1Kbi/Pf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1Kbi/Pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E9BC32782;
	Mon, 12 Aug 2024 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723495583;
	bh=BFoX/qrFoQp39Oml7ZScH5DCyVCYHo4zgqWnP4mlhkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1Kbi/PftL4upq+gPUnhjBCgBe9HEO1iloSYXCfyNjCWV+exmjhuA2N2yBdrrBSoV
	 WE/1UfiLSKALv8KDpkdMdmmLYaS2xXu1VBUmy0uZEm9el1uvjzWKvlkGQ9M6xY/ZEf
	 s/UKFVEqQncUq2+QEODGOZTBAHQx3t1UkhaTBsCbMzlEWBNX+zJVW+YzhAESWC6+z/
	 hFaFS7YKgDD32PbaOWIYcJD/9+jUYA8ONxEAVW0K7iKJTNR5/2o9z/d6G7Pag8b5td
	 XKNSq8OJ60HJznMhAUDAyzxigeh32EdnFve3Osn0qvKJOJcpAVygc1i7Pb+8sLWXHG
	 tWJmONrA/u5DA==
Date: Mon, 12 Aug 2024 17:46:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] perf annotate-data: Implement folding in TUI browser
Message-ID: <Zrp0m53X7STRB8gU@x1>
References: <20240812194447.2049187-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812194447.2049187-1-namhyung@kernel.org>

On Mon, Aug 12, 2024 at 12:44:44PM -0700, Namhyung Kim wrote:
> Hello,
> 
> I've implemented the folding logic to expand/collapse the current entry
> in the TUI data type browser.  Users can use 'e' or 'E' to toggle the
> entry (with or without children, respectively).
> 
> Ax example output looks like below.
> 
>   Annotate type: 'struct socket' (1 samples)
>         Percent     Offset       Size  Field
>   -      100.00          0        128  struct socket {                                  ◆
>            0.00          0          4      socket_state   state;                        ▒
>            0.00          4          2      short int      type;                         ▒
>            0.00          8          8      long unsigned int      flags;                ▒
>            0.00         16          8      struct file*   file;                         ▒
>          100.00         24          8      struct sock*   sk;                           ▒
>            0.00         32          8      struct proto_ops*      ops;                  ▒
>   -        0.00         64         64      struct socket_wq       wq {                  ▒
>   -        0.00         64         24          wait_queue_head_t  wait {                ▒
>   +        0.00         64          4              spinlock_t     lock;                 ▒
>   -        0.00         72         16              struct list_head       head {        ▒
>            0.00         72          8                  struct list_head*  next;         ▒
>            0.00         80          8                  struct list_head*  prev;         ▒
>                                                    };                                   ▒
>                                                };                                       ▒
>            0.00         88          8          struct fasync_struct*      fasync_list;  ▒
>            0.00         96          8          long unsigned int  flags;                ▒
>   +        0.00        104         16          struct callback_head       rcu;          ▒
>                                            };                                           ▒
>                                        };                                               ▒
> 
> It hides the detail of spinlock_t and struct callback_head.

Thanks, useful feature! All tested and applied.

- Arnaldo
