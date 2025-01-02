Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEE1ADFEB;
	Thu,  2 Jan 2025 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735843295; cv=none; b=bE+sj42J4xem0LGJ0uPQaNSRk4G5iC4mT4carbuCtz0QiH8tvGlO+Xnpgy4fjEGc2YAWPwc+6QN7koWHCDeFgKR3yFvgpXe0Ai4woMNY+xsQVc6RPeK1frFmkJJOa2ET+QEwbhGSCDSbpChig1iHsrU7juVSo6El0/BttqAZCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735843295; c=relaxed/simple;
	bh=rk9wFUdfwveU8nDd8zWymVGU+FNvi4u0Le0vwNdi1S8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XNvb3aVLUd+bhtbnM3VoVIa9dhf9ot7bL1HCOyKWMeST4VZjqCn85bBS0bIRaHwa9/lcT+Ypmytjhz/rK/JoEqo6eOLHnpjwFteiRLvQ7ymBPTvVCSszaYbxMnpoN6JwedFKs6gWT4bNhhN4gbSJ0cBze4WGgl7qiaIlyqhRFVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRYYnKYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRYYnKYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E198C4CED0;
	Thu,  2 Jan 2025 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735843294;
	bh=rk9wFUdfwveU8nDd8zWymVGU+FNvi4u0Le0vwNdi1S8=;
	h=Date:From:To:Cc:Subject:From;
	b=kRYYnKYyYw7bo9VewN2PsHVZFmpsAARSAMvnCcGwrwmvvPnTj2UWvU+0I009z4HRp
	 ndWIAg7Rc7W0sJUpKKxeCux9KkkgnSzFY7HOnDqzosZI6pg53llIAzrxC19sAFF+XA
	 SVEngJ27DaWP1X3rNiO5ULwcQC8V+I8xdtHI+fqi5Fpu9TzyCp0sIVRCNp470buBM/
	 sUsHfwmB3BJur2reAeAne0Y5QqtD9rjjc3FyR6qPoCM0le+NfhylAJG9anSERVapdG
	 kG6ODmAXmkVEGPuQ1Y+ypKQaT20fwNUMgJeySaBSVCM5O17HkFWXiPOOMsyoCD3lAk
	 NBvz6r/jgevLQ==
Date: Thu, 2 Jan 2025 15:41:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [BUG] perf top reports not being able to resolve kernel symbols
Message-ID: <Z3bd2uCdo2EAMSnG@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

While investigating a report by Christophe I stumbled on this:

⬢ [acme@toolbox perf-tools-next]$ git bisect bad
77b004f4c5c3c90b20ad61c5fa2ba7d494c1dba1 is the first bad commit
commit 77b004f4c5c3c90b20ad61c5fa2ba7d494c1dba1 (HEAD)
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Thu Sep 12 15:42:08 2024 -0700
    perf symbol: Do not fixup end address of labels

⬢ [acme@toolbox perf-tools-next]$ git tag --contains 77b004f4c5c3c90b20ad61c5fa2ba7d494c1dba1 | grep ^v6
v6.13-rc1
v6.13-rc2
v6.13-rc3
v6.13-rc4
v6.13-rc5
⬢ [acme@toolbox perf-tools-next]$ 
⬢ [acme@toolbox perf-tools-next]$ git merge perf-tools/perf-tools
Already up to date.
⬢ [acme@toolbox perf-tools-next]$ git merge perf-tools/tmp.perf-tools
Already up to date.
⬢ [acme@toolbox perf-tools-next]$

Running just:

# perf top --stdio
   PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: 0/0 [cpu_atom/cycles/P],  (all, 28 CPUs)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Warning:
A vmlinux file was not found.
Kernel samples will not be resolved.
^C^C^C^Z
[1]+  Stopped                 perf top --stdio
root@number:/home/acme/git/pahole# 

But kernel addresses are being used and there is a matching vmlinux:

# pahole --running_kernel_vmlinux
/lib/modules/6.13.0-rc2/build/vmlinux
#

root@number:/home/acme/git/pahole# file /lib/modules/6.13.0-rc2/build/vmlinux
/lib/modules/6.13.0-rc2/build/vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=d6f220b80bb50b35238aec50ed10f98df58849c0, with debug_info, not stripped
root@number:/home/acme/git/pahole# perf buildid-list --kernel
d6f220b80bb50b35238aec50ed10f98df58849c0
root@number:/home/acme/git/pahole# 
root@number:/home/acme/git/pahole# perf buildid-list -h --kernel

 Usage: perf buildid-list [<options>]

    -k, --kernel          Show current kernel build id

root@number:/home/acme/git/pahole#

I'm trying to figure this out now.

- Arnaldo
