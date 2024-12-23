Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861CE1AF0C2;
	Mon, 23 Dec 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734982830; cv=none; b=nwkOMFFyxJfLIiVf9kYNBY4mWwwV9X/U1FotlBznlkBIGpbPwfWte7CsylBSB+3bv3bQxLi6meQejSMGhnNTDpsh3xryL9tfRCcKMqxZHwq2FbSF5cdENFLwJ3yE2wrnNfznwkmZweXwqzjP1SRCln8n/GrCFllf/ipoM3m9FIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734982830; c=relaxed/simple;
	bh=aDrX5GK4Z9XFeu9FdRLyGBtnq1fu4S+7J7BT0Z8jOlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lczQccY8Qw0Afz4r1k8Eq4EE6yz1oAQOg1PyWMx0LsDU3mV6sZx9okPQD+ZrzqvzHNO+Qewz7mRuNaNfWX/9D7r7lkZIe9js81mVXUWl93X/9RCbwCop12xwxj+pkYh5qjXPfsn6wREw42A+u4vvChlMLiPs2l3fyYLk8sTcLgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmiliiiJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmiliiiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747BEC4CED3;
	Mon, 23 Dec 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734982830;
	bh=aDrX5GK4Z9XFeu9FdRLyGBtnq1fu4S+7J7BT0Z8jOlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmiliiiJ1gQNgOskNrcN09MMW3hLqULcA0gkGGFHjimE677lJPXx3DB2bLbqNdaBy
	 juc+3keuDMh+Bf936HbvqY/Wy2UW3HWdfbCjvfFgMoRgUObETYJT4yndLDybTVb7CZ
	 2D2qA+w3w2mAC8hkIgAf8qzJVb+QRDVFFh2JVkGC+joZExexxv9dUn664ySQZOrIDy
	 RnKO/kPODxqYJOuP5p52bdqP2ymY7meKhghOMLdtBAr19vuNPjFl8uzICkaBhyj32P
	 vii+bWKZvmkF2tE9+tbESMEu2Zp6SRO3tFdNlWjzkNown5GbGlYWlVQ/Zjddl7zBHw
	 RIGHAS6jfhnHg==
Date: Mon, 23 Dec 2024 16:40:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] perf trace: Add more tests for BTF-augmented perf
 trace
Message-ID: <Z2m8qzyLdm1BEYuF@x1>
References: <20241215190712.787847-1-howardchu95@gmail.com>
 <Z2CGdi5xpJy6C6sv@google.com>
 <Z2mzzytPOpjF0Hxe@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2mzzytPOpjF0Hxe@x1>

On Mon, Dec 23, 2024 at 04:02:43PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Dec 16, 2024 at 11:58:46AM -0800, Namhyung Kim wrote:
> > On Sun, Dec 15, 2024 at 11:07:09AM -0800, Howard Chu wrote:
> > > Changes in v4:
> > >  - Use if -f to check the existence of vmlinux BTF, and exit if it
> > >    doesn't, so trace_test_string will not overwrite $err, and keep
> > >    running the test.
> > > 
> > > Changes in v3:
> > >  - Add vmlinux BTF check, and skip the tests if it doesn't exist
> > > 
> > > v1, v2:
> > > 
> > > The previous version of the perf trace BTF general augmentation tests
> > > didn't pass Shellcheck (thanks to Arnaldo Carvalho de Melo
> > > <acme@kernel.org> for pointing this out), this version uses bash instead
> > > of POSIX shell to pass Shellcheck.
> > > 
> > > This patch series also adds documentation for the new option
> > > --force-btf, which is used in the tests.
> > > 
> > > Link: https://lore.kernel.org/linux-perf-users/Zt9yiQq-n-W6I274@x1/
> > > 
> > > Howard Chu (2):
> > >   perf trace: Add tests for BTF general augmentation
> > >   perf docs: Add documentation for --force-btf option
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks, applied to perf-tools-next,

It fails when running in parallel mode, sometimes:

109: perf trace BTF general tests                                    : FAILED!

Then:

root@number:~# perf stat --null -r 10 perf test "BTF general"
109: perf trace BTF general tests                                    : Ok
109: perf trace BTF general tests                                    : Ok
109: perf trace BTF general tests                                    : Ok
109: perf trace BTF general tests                                    : Ok
109: perf trace BTF general tests                                    : FAILED!
109: perf trace BTF general tests                                    : Ok
109: perf trace BTF general tests                                    : Ok
109: perf trace BTF general tests                                    : FAILED!
109: perf trace BTF general tests                                    : Ok
109: perf trace BTF general tests                                    : Ok

 Performance counter stats for 'perf test BTF general' (10 runs):

             2.148 +- 0.293 seconds time elapsed  ( +- 13.63% )

root@number:~#


So its not just when running in paralell, anyway, its merged, we can go
on from what we got there.

- Arnaldo
