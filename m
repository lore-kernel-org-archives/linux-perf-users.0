Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794412C819
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Apr 2024 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378383; cv=none; b=uWUPb2JUQVtQSBAOCCSOcJ+8eiO66Lm5W4W+nMx/wQn5w6VXHKPYKtja4j9dtwOx4TdgJQ32hYCJKkXJEzijoHSwA4/kHQS0wFnqwvyHCdIOG1qspq8G/NQkolw8YFD26Aev94+pfbwcmKvQtOqfzJwkvLQN9tRxg3/Ui55+QSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378383; c=relaxed/simple;
	bh=DBiEtbiPW0Q/ik1A7Xlv/HTSL1p60+rlNKwwgTun/YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDHpIFIP9S0Jx9ligm2YvcQ6cbqaC2bdXChKbMearPgnrTbHD+EUedN+b208swS/30jALFXUW2nRbUFiYCgPAweMJJ3CrXxmqORbUKDUuED+xL7aM3VMxGFKlPc9TV5lj56+Kz/av+4t/mPLBvJZOxY4aIDXVJdf9cFl6Cal29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGdap3+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGdap3+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F05C2BD11;
	Wed, 17 Apr 2024 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713378382;
	bh=DBiEtbiPW0Q/ik1A7Xlv/HTSL1p60+rlNKwwgTun/YQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGdap3+6Ys2MvYJaqipIPb+jWiFGqjeRK/CKutY3Ej0V1kG6D9N8v3kp4McBx3RCW
	 yQt861krwTbKcxNp2HzWeEb+XC52tWsQkDJpAh5HgpvM8YMul/nOK0llEyqd8abYSH
	 FBhKxBUNDbu/oVlUFFb1X1uQghoW2YmIX8MC0syRIKp2QDwOS6FSTgFfLtnutS+eFM
	 WIbtQfiNCNWxcavgta6oiLjs74ZrL9Ye96vmJVntcxmgF10QJRjrNK0B3fnBLm297C
	 7HUkshNeh0/ij29RVmOcTqNp/Lsxpae87kzdO2NX1wwmG0IdYsH4Ld7+FTGxkGChTm
	 PBiNcZld/YfwA==
Date: Wed, 17 Apr 2024 15:26:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>,
	linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
	james.clark@arm.com
Subject: Re: [PATCH V2 8/8] perf test: Check output of the probe ... --funcs
 command
Message-ID: <ZiAUSxRYTty5uh6m@x1>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
 <20240408062230.1949882-9-ChaitanyaS.Prakash@arm.com>
 <20240409080902.6f2ccd1239c64ca49861d6d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409080902.6f2ccd1239c64ca49861d6d6@kernel.org>

On Tue, Apr 09, 2024 at 08:09:02AM +0900, Masami Hiramatsu wrote:
> On Mon,  8 Apr 2024 11:52:30 +0530
> Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com> wrote:
> 
> > From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> > 
> > Test "perf probe of function from different CU" only checks if the perf
> > command has failed and doesn't test the --funcs output. In the issue
> > reported in the previous commit, the garbage output of the --funcs
> > command was being ignored by the test when it could have been caught.
> > 
> > An additional check to grep for "foo" has been added to test the --funcs
> > output.
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> > +++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> > @@ -77,7 +77,7 @@ gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
> >  gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
> >  gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
> >  
> > -perf probe -x ${temp_dir}/testfile --funcs foo
> > +perf probe -x ${temp_dir}/testfile --funcs foo | grep "foo"
> >  perf probe -x ${temp_dir}/testfile foo

Have you tested this?

Because:

root@x1:~# perf probe -x /lib64/libc.so.6 malloc | grep malloc || echo failure
Added new event:
  probe_libc:malloc    (on malloc in /usr/lib64/libc.so.6)

You can now use it in all perf tools, such as:

	perf record -e probe_libc:malloc -aR sleep 1

failure
root@x1:~# perf probe -d *:*
Removed event: probe_libc:malloc
root@x1:~# perf probe -x /lib64/libc.so.6 malloc |& grep malloc || echo failure
  probe_libc:malloc    (on malloc in /usr/lib64/libc.so.6)
	perf record -e probe_libc:malloc -aR sleep 1
root@x1:~#


that plain '| grep "foo"' isn't enough, will always fail, as the output
isn't sent to stdout, but to stderr, so, with your patch:

root@x1:~# perf test different
121: test perf probe of function from different CU                   : FAILED!
root@x1:~# set -o vi
root@x1:~# perf test -v different
121: test perf probe of function from different CU:
--- start ---
test child forked, pid 938178
--- Cleaning up ---
"foo" does not hit any event.
  Error: Failed to delete events.
---- end(-1) ----
121: test perf probe of function from different CU                   : FAILED!
root@x1:~# 


We need to use '|&' to grep in both stdout and stderr, see how 'perf
probe' uses stderr:

root@x1:~# perf probe -d *:*
Removed event: probe_libc:malloc
root@x1:~# perf probe -x /lib64/libc.so.6 malloc > /dev/null
Added new event:
  probe_libc:malloc    (on malloc in /usr/lib64/libc.so.6)

You can now use it in all perf tools, such as:

	perf record -e probe_libc:malloc -aR sleep 1

root@x1:~


Using '|&' to grep:

diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 82bc774a078a15d5..af8b1fa639f3daa4 100755
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -77,7 +77,7 @@ gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
 gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
 gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
 
-perf probe -x ${temp_dir}/testfile --funcs foo | grep "foo"
+perf probe -x ${temp_dir}/testfile --funcs foo |& grep "foo"
 perf probe -x ${temp_dir}/testfile foo
 
 cleanup
⬢[acme@toolbox perf-tools-next]$

root@x1:~# perf test different
121: test perf probe of function from different CU                   : Ok
root@x1:~# set -o vi
root@x1:~# perf test -v different
121: test perf probe of function from different CU                   : Ok
root@x1:~# perf test -vv different
121: test perf probe of function from different CU:
--- start ---
test child forked, pid 1048947
Added new event:
  probe_testfile:foo   (on foo in /tmp/perf-uprobe-different-cu-sh.5qg9UX2dUJ/testfile)

You can now use it in all perf tools, such as:

	perf record -e probe_testfile:foo -aR sleep 1

--- Cleaning up ---
Removed event: probe_testfile:foo
---- end(0) ----
121: test perf probe of function from different CU                   : Ok
root@x1:~#

I'm amending the patch with this fix.


Thanks,

- Arnaldo
