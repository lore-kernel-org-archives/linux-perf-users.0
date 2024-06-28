Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818EA4CB37;
	Fri, 28 Jun 2024 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604096; cv=none; b=H7jOCO8kGE37ipEJ1mN2MZas5GLDtbSSU3C4KX06uJDLdNj2clWznHrgRmaDS1d5xt1AnoZEeqV3A71zN8q9/631XtJ8K/GsWRR4rM0HwWhp3iiCjbzSHJ454U+fUUQe8vQAEaueVuP7l3wk4Wa7zpwGDRM1dS++y9TLRl9qdtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604096; c=relaxed/simple;
	bh=5FdmDkaWpo3LN7jjmcP0NcHbokgjZpTdv+O+AA9Pzgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYn24OUqA4EFoiOUAYTR3R9mpGhlCZOw8tIG0+dxt+rtTaUrL7z3qDQ49E7njUnHzUV3UDqB5bDANKcRualBUw3Ea/0sGT4FMpOKBZ7mnHKCVinnUn6paKuomOVO6CdrPfaEZDQqifQDMs3uUIUV0m85HsG+mtjgoRPzM75LwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHy2RwaK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHy2RwaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0B3C116B1;
	Fri, 28 Jun 2024 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719604096;
	bh=5FdmDkaWpo3LN7jjmcP0NcHbokgjZpTdv+O+AA9Pzgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHy2RwaKCuVGRDcOUI5i2ynt5XTskyxExuOwDLTbiD4FSnMkFv+nqJI+ie8/GLbKn
	 HTyviYO1Hw+/LNJ8z/EAN4qTaprMul/rh3exbyfj7eL4s+rDd49YpjpyqOJPFDebDH
	 Z50Ytv6eL9FEJDX5cZ+wh6BUfyb1eeqJdEtfhEJ01gLiJOyiaO6txGFQcIf+dBe6Pm
	 iqEuzc9/6mCEN8q9vkwSe3PpBg+eV2mzsaN3bqNJgPzChd3CLlm8N/YhM6AtaWyRLW
	 zqv20u6DZcBzX4MNNTVydvGyTNZ+R93TGvIzok+5k8vhMwxpwVInLhL7byy8vS7U/Z
	 dLa3xo3/3UJZw==
Date: Fri, 28 Jun 2024 12:48:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, adrian.hunter@intel.com,
	irogers@google.com, jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] perf trace: Augment enum arguments with BTF
Message-ID: <Zn8TfuQi0iq7bMVD@google.com>
References: <20240624181345.124764-1-howardchu95@gmail.com>
 <Znnt4sTOx6ANJZPV@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Znnt4sTOx6ANJZPV@x1>

On Mon, Jun 24, 2024 at 07:06:26PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Jun 25, 2024 at 02:13:37AM +0800, Howard Chu wrote:
> > In this patch, BTF is used to turn enum value to the corresponding
> > enum variable name. There is only one system call that uses enum value
> > as its argument, that is `landlock_add_rule()`.
> > 
> > Enum arguments of non-syscall tracepoints can also be augmented, for
> > instance timer:hrtimer_start and timer:hrtimer_init's 'mode' argument.
> > 
> > Changes in v3:
> 
> Did a quick test, from a quick look you did the adjustments we agreed
> (if (val == 0 && !trace->show_zeros && !arg->show_zero && arg->strtoul
> != STUL_BTF_TYPE), etc), thanks!
> 
> And that is the way for collaboration we go on talking on the mailing
> list and sometimes writing code, making it available for review and
> adopting what we deem best at that point, rinse repeat.
> 
> Now I think it would be great if someone like Namhyung or Ian could try
> this last patch.
> 
> I have to comb thru it but, again, from a quick look and test, it seems
> great and probably ready for merging.

So I'm trying to test this but I got a build error like this:

tests/workloads/landlock.c: In function ‘landlock’:
tests/workloads/landlock.c:22:16: error: variable ‘net_port_attr’ has initializer but incomplete type
   22 |         struct landlock_net_port_attr net_port_attr = {
      |                ^~~~~~~~~~~~~~~~~~~~~~
tests/workloads/landlock.c:23:18: error: ‘struct landlock_net_port_attr’ has no member named ‘port’
   23 |                 .port = 19,
      |                  ^~~~
tests/workloads/landlock.c:23:25: error: excess elements in struct initializer [-Werror]
   23 |                 .port = 19,
      |                         ^~
tests/workloads/landlock.c:23:25: note: (near initialization for ‘net_port_attr’)
tests/workloads/landlock.c:24:18: error: ‘struct landlock_net_port_attr’ has no member named ‘allowed_access’
   24 |                 .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
      |                  ^~~~~~~~~~~~~~
tests/workloads/landlock.c:24:35: error: ‘LANDLOCK_ACCESS_NET_CONNECT_TCP’ undeclared (first use in this function); did you mean ‘LANDLOCK_ACCESS_FS_TRUNCATE’?
   24 |                 .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                   LANDLOCK_ACCESS_FS_TRUNCATE
tests/workloads/landlock.c:24:35: note: each undeclared identifier is reported only once for each function it appears in
tests/workloads/landlock.c:24:35: error: excess elements in struct initializer [-Werror]
tests/workloads/landlock.c:24:35: note: (near initialization for ‘net_port_attr’)
tests/workloads/landlock.c:22:39: error: storage size of ‘net_port_attr’ isn’t known
   22 |         struct landlock_net_port_attr net_port_attr = {
      |                                       ^~~~~~~~~~~~~
tests/workloads/landlock.c:30:45: error: ‘LANDLOCK_RULE_NET_PORT’ undeclared (first use in this function); did you mean ‘LANDLOCK_RULE_PATH_BENEATH’?
   30 |         syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
      |                                             ^~~~~~~~~~~~~~~~~~~~~~
      |                                             LANDLOCK_RULE_PATH_BENEATH
tests/workloads/landlock.c:22:39: error: unused variable ‘net_port_attr’ [-Werror=unused-variable]
   22 |         struct landlock_net_port_attr net_port_attr = {
      |                                       ^~~~~~~~~~~~~

And I found it's reported before:
https://lore.kernel.org/linux-perf-users/Zn5aGnyjyCqAX+66@rli9-mobl/

It seems my system has an old copy of the linux/landlock.h and it
doesn't have the new struct and macro.  I think you can change it to
include what we have in the source tree.  Maybe like

#include "../../../../include/uapi/linux/landlock.h"

Probably the same for the syscall number by reading it from unistd.h in
the source tree.  Then we probably don't need to make it conditional as
we use the latest version.  But I'm not sure if it's ok to read the
syscall number from asm-generic header since it might be different on
other arch.

Thanks,
Namhyung

