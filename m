Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8DF1F3BA9;
	Fri, 27 Jun 2025 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050388; cv=none; b=DDai5u6B/8kiXB9rTWysQo+RbbcUoGuZcnkE5CLeoetSZt4bxzvivJKdx/XCErjGX9EAfk6Aa4elKiTTUZyoh5Zkq+q5gSy0aiVpAucrpTIaU0ZRCNydbqghDU/5w/6bTcvB2vgWUmg40BxF7pKBrhHmn+Botl6RrKzdZFCKYN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050388; c=relaxed/simple;
	bh=UU3NgphBimivp+jVyBXDXxoYFJzoxBfiVs1YEtKHDZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c3+NmDIHpOmfpChsrTV9wMovXGM4YLo+Z3969QFp1QlgJOcolmudgnWXNBmuifIk0KJ8fTmLTGTeFvrRniFqiVRWMFL9zbL/rVMXdx3kbOUBSuARjXn3qUXf/9iz8aufH5KFrGHoIQP7VYo+65NbuWS0VsN5kM3vFCsGXyPsCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZtMCoW3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZtMCoW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE79AC4CEE3;
	Fri, 27 Jun 2025 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751050388;
	bh=UU3NgphBimivp+jVyBXDXxoYFJzoxBfiVs1YEtKHDZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cZtMCoW3/t06S7YgdFm754ENWsX2hXrI/XyJL32PDtOjjJpS88YNDWaSQnv7PYiVV
	 /hr6XaVUbDQ0/2tmJe8IKzMKQ8YO/EOeeKZNjELcDlrtJeQFLDiqSbBLERHYBES9V0
	 Cen6LfY3QiLEom/VfkK8coN2vpdcpC9w2UagAdmmDt0tCMZERs+vgLCDeb4ahJ5jJi
	 L2TT94yC5awMNCevmYzayNtQpXjuw4djK+kP/ClPK/4M5zr69dgLU3FCaaq+F7nklL
	 vGw0lQLRFes0L4JztGsjGfwMIfFapdnyIdYmi/+5CetuF1r57jrlyOwJlshK7mHV5x
	 SVj/UEW9TT7+w==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Tianyou Li <tianyou.li@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, wangyang.guo@intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250625161509.2599646-1-tianyou.li@intel.com>
References: <aFrzSpvzzWeHdyJ5 () google ! com>
 <20250625161509.2599646-1-tianyou.li@intel.com>
Subject: Re: [PATCH V2] tools/perf: Add --exclude-buildids option to perf
 archive command
Message-Id: <175105038774.2492671.5711747632083820597.b4-ty@kernel.org>
Date: Fri, 27 Jun 2025 11:53:07 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 26 Jun 2025 00:14:01 +0800, Tianyou Li wrote:
> When make a perf archive, it may contains the binaries that user did not want to ship with,
> add --exclude-buildids option to specify a file which contains the buildids need to be
> excluded. The file can be generated from command:
> 
>     perf buildid-list -i perf.data --with-hits | grep -v "^ " > exclude-buildids.txt
> 
> Then remove the lines from the exclude-buildids.txt for buildids should be included.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


