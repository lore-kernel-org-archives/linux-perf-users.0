Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818A881E;
	Fri,  3 Jan 2025 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735866998; cv=none; b=K1NV7VIOGqVPMRuJtMN7cZhSjFEWp7JW/+Q1lOFw4PQzxAtKso/NtfU7oqMaaoiTHmInx1sMMaZFAmPVpuXQuokq2xzjjKBtJ3CqGwrobtXIuUCJcNz/WWCFaW9OXYaG0ZB/7qVIbyD7dRLq2w291EDJ8qHtAlqIRJ/Ql4lbadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735866998; c=relaxed/simple;
	bh=70uDWWDAhtKyumZs2HgJ1+osWruUuFbh6oFUdnF2jq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t12j84cDvBuKxMAf7eG1ty6dh+c2QcxkZD6odJfUiULOYSM8cRj0Dr8nMNKsem2W1UY9KNCzI8/NxQk53b+lvbev7K3N3Jp7tu8z3YCndRH0JG+iBdVu3DmDqj3klftlp1mAX6WAJkzdl+FW4RTLjVhcPHM3Sy7LM+EahmGKXYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJnjS6LZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJnjS6LZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C74C4CED0;
	Fri,  3 Jan 2025 01:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735866998;
	bh=70uDWWDAhtKyumZs2HgJ1+osWruUuFbh6oFUdnF2jq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJnjS6LZPL+u5n0Avg1a8rtFbyjDWuETjrqh6Wxa+lW1juvKj3f3uDqr8bOv1+oKs
	 WK4kTM2viuH8VMw2DZfSLfPzJUW9DTqSR8SjrfDKT77QZsKuYAM6YrcGSKyQKvegLI
	 qAU+lowIchyhQiBeFKQ00narxoNTEA3TqTgj2ays5W7h77khgt5Xp4G4d5dQW1xEWT
	 LL3q+b+TSr+1QioxYxkqNiu1kN5hhFL5ihKShtaJu2k+OcvxorW23TtrK+Cpi1oYYz
	 XV8hxe4TUkefutNssG10sgE2sJak53Z+R0AtbXy5DWrIdhsLRX+aKZ7lqo+o/Qgkp/
	 7UFoF2SnhWpjg==
Date: Thu, 2 Jan 2025 22:16:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf top reports not being able to resolve kernel symbols
Message-ID: <Z3c6cwACnzku_ntQ@x1>
References: <Z3bd2uCdo2EAMSnG@x1>
 <Z3boDyuus0fiGcok@x1>
 <Z3buKhcCsZi3_aGb@x1>
 <Z3b-DqBMnNb4ucEm@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3b-DqBMnNb4ucEm@google.com>

On Thu, Jan 02, 2025 at 12:58:54PM -0800, Namhyung Kim wrote:
> On Thu, Jan 02, 2025 at 04:51:06PM -0300, Arnaldo Carvalho de Melo wrote:
> > So there are symbols that are not being resolved anymore that were
> > before your patch, namely:

> > arch/x86/entry/entry_64.S

> > nmi_no_fsgsbase:
> >         /* EBX == 0 -> invoke SWAPGS */
> >         testl   %ebx, %ebx
> >         jnz     nmi_restore

> > nmi_swapgs:
> >         swapgs

> > nmi_restore:
> >         POP_REGS
 
> Sorry about that, maybe I should've done this instead.  Can you check
> if it works correctly?

Its late here, but basic test shows samples being resolved to
nmi_restore, when using the TUI 'perf top' interface and pressing / to
ask for samples resolved to samples with 'nmi' on its name, several
other such routines appeared on the radar, including:

Samples: 2K of event 'cpu_atom/cycles/P', 4000 Hz, Event count (approx.): 496683332 lost: 0/0 drop: 0/0
Overhead  Shared O  Symbol
   0.05%  [kernel]  [k] ct_nmi_enter
   0.04%  [kernel]  [k] local_touch_nmi
   0.01%  [kernel]  [k] ct_nmi_exit
   0.01%  [kernel]  [k] nmi_restore
   0.00%  [kernel]  [k] nmi_handle

[1]+  Stopped                 perf top
root@number:~#

So:

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>

And preliminarly:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks, I'll submit the other patch, that now doesn't need to go into
the 6.13 window and thus can be added to the perf-tools-next branch,
tomorrow.

- Arnaldo
