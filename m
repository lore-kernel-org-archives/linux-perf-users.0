Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCBB2D780E
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050909; cv=none; b=FDOQTJuHFF50b8W8QVowhUIH5VeG+T3IuKHe5wnsgII++q1lRXWBfb7GtfxVyPj27O0l9+U1DkFD3sir5yfsGG4CKaLQyT5XN9a27d5Yn4/sb81KVZ6pXzvtcp89OIK8Ep84COwRdXGScsV13hHTnP4bBmKy+UMRl5vP7yLbFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050909; c=relaxed/simple;
	bh=FAym0ETu7lUUIFjUyxtsN7QDfHeDuIZVb6OttQLe2Dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XV4Q5gk2RBNIr5ZL46+TSHZidYgriZV7ggPCGQOuIeJBom9n2gN1Kht6Iy+/mRnI5pPE47MT2oBqGYBt4u0ziE22lA/AJ4d1S01zYfhEwMti+uOVjlsw11/VpjVv93oLXzNf3plAuiCLTtZTCXVPkdDYluFzYDigwMFJoHwFRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4lK9fZa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4lK9fZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF9FC19425;
	Fri, 24 Apr 2026 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050908;
	bh=FAym0ETu7lUUIFjUyxtsN7QDfHeDuIZVb6OttQLe2Dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=a4lK9fZaoxC1LYkHU/do5aAQNp97eqUrCwGosg7SJHeLtXmQvrpNUbgReNUhWjVyU
	 Wmr4BXnDT8N9Sh8O+ua+tztCedWe8gSP+z+9PwLnVl4+/Z8iEAIFnfu9jfYe+rr364
	 deFInGdivOhYr6SDXOIDwb2B52d17DuWLEEM+Rze07+yz7awwrPvyXQ9cMIqqrYrKR
	 r5AML6pxYn6NcLqdp3HF9tPxpomFQH3wMA0/vptH2NJCivV9QxIS9CECfkjCo7TC+B
	 9h/GUl3BKlIhXizHBxeJoUAZXeHhCL3CYZqzL+VGgvSL/ctZjrRgHpAwKLpYX+huWF
	 yx3QMPcwm7zOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 24/58] perf python: Move exported-sql-viewer.py and
 parallel-perf.py to tools/perf/python/
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-25-irogers@google.com>
References: <20260424164721.2229025-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:15:08 +0000
Message-Id: <20260424171508.CDF9FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Moving `exported-sql-viewer.py` and `parallel-perf.py` to `tools=
/perf/python/` breaks their installation and skips the `parallel-perf` test=
 because `Makefile.perf` is not updated in this commit.
--

commit c423130f6ca40765cfc1d50d745c2cdf9bf08db1
Author: Ian Rogers <irogers@google.com>

perf python: Move exported-sql-viewer.py and parallel-perf.py to tools/perf=
/python/

This commit moves standalone Python scripts from tools/perf/scripts/python/=
 to
tools/perf/python/. It updates the test script to reference the new paths.

[ ... ]

> diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/sc=
ript.sh
> index 7007f1cdf761b4..2051c6e055695b 100755
> --- a/tools/perf/tests/shell/script.sh
> +++ b/tools/perf/tests/shell/script.sh
> @@ -76,7 +76,7 @@ test_parallel_perf()
>  		err=3D2
>  		return
>  	fi
> -	pp=3D$(dirname "$0")/../../scripts/python/parallel-perf.py
> +	pp=3D$(dirname "$0")/../../python/parallel-perf.py
>  	if [ ! -f "${pp}" ] ; then
>  		echo "SKIP: parallel-perf.py script not found "
>  		err=3D2

Does moving these scripts without updating tools/perf/Makefile.perf break t=
he
installation step and cause this test to skip?

Prior to this patch, Makefile.perf copied scripts/python/*.py to the
installation directory. Since the Makefile isn't updated in this commit, the
scripts are omitted from make install.

When perf test runs from an installed tree, it expects to find
parallel-perf.py at the installed python/ directory. Since the installation=
 is
missing, the test silently skips.

I see this is fixed in a later commit 00f5f415c2dee0 ("perf Makefile: Update
Python script installation path"), but does leaving the Makefile out of this
commit break bisectability?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D24
