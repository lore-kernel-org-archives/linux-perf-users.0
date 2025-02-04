Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5D25A642;
	Tue,  4 Feb 2025 03:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738639015; cv=none; b=jvLuz/YvNgMU67qA67MOgrOP9LRkHZGBPYW/KH0uTPwIuGo19ZAb54uQfK8RuQkm2RmAIkgQRRpKe+j2NmHWOV9YOwsr3AEztpHdn15aBng9IV0LwijQZEnl/K/BlnPZ4/Eop8FKTW06ilGop2UZNerMCX8XQmCLwejp6SEenYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738639015; c=relaxed/simple;
	bh=8yZPNqS5d98IriYN09CKCfWNzhvpa+wDnKjXpV8RWdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaHE61wvykN3yTE6diNEl0qTVtsDsxL26TK/gZJuNEcplE7JeS6KlHbQa40kt8SVUhzmZJdoxrJzc6aAp8VoWN3GPhqRdEzEZuwAdTWmH1znFtR3ZhTMo2WtOuTzKF31KsY/Fh0kN3Pv7KMyw3Rydo+eRXPdOg4LRE8cGsIznzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRNr4Vbj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRNr4Vbj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9938AC4CEE0;
	Tue,  4 Feb 2025 03:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738639015;
	bh=8yZPNqS5d98IriYN09CKCfWNzhvpa+wDnKjXpV8RWdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRNr4VbjKnQo/twao6kw7WtVfBagU96Y4/MWczcP8o+G81plu2dmWczzxb2zg4PAA
	 TwknuZlIC1ZZe74usS1lWAR6elOhKRowffNgEm2CbUZFf2m5CTE5GJlcihxJlfieoH
	 Onlt3ZTOCbDxVqrwj+EdCB5JjzEjtaHMcqM3ohiMzeacWQcDaEMr0h8f5OXtLi9OcK
	 wCc58kWaj2fMRHMrzHANcE4AgZThePJA90YUNTTZef41SgFc8uqnsh9JLEUGg9uHMv
	 LMUTcQ8j/PvUQ1aJQF7NsJ2WzgUsDG3iaedihyn530VhVD/araXI2MqPSWZkTHSstr
	 ZWUHsX+VPT5FA==
Date: Mon, 3 Feb 2025 19:16:53 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] perf trace: Add more tests for BTF-augmented perf
 trace
Message-ID: <Z6GGpcTMvw5z6A5V@google.com>
References: <20241215190712.787847-1-howardchu95@gmail.com>
 <Z2CGdi5xpJy6C6sv@google.com>
 <Z2mzzytPOpjF0Hxe@x1>
 <Z2m8qzyLdm1BEYuF@x1>
 <CAH0uvoga29=0iF69A5uHN+nbB458LeW+WDWHNnoQV4msVm9zDQ@mail.gmail.com>
 <Z4U343yQUDF3H7qs@x1>
 <Z4vyvNChyXZx33xf@google.com>
 <CAH0uvoiRTnT-=EeK1z6BajB9RE5F=f2S4e5a5ygo8kebyKyCqw@mail.gmail.com>
 <Z5LWkMPTu6mUtdJ-@google.com>
 <CAH0uvoit+6nhADW_d61VcaSE17Wp5DH7BtUVjQdT=kU9rMqaaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvoit+6nhADW_d61VcaSE17Wp5DH7BtUVjQdT=kU9rMqaaA@mail.gmail.com>

On Fri, Jan 31, 2025 at 04:14:09PM -0800, Howard Chu wrote:
> Hello Namhyung,
> 
> Sorry for somehow missing this reply...
> 
> On Thu, Jan 23, 2025 at 3:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Jan 21, 2025 at 04:19:35PM -0800, Howard Chu wrote:
> > > Hello Namhyung,
> > >
> > > On Sat, Jan 18, 2025 at 10:28 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Mon, Jan 13, 2025 at 12:57:23PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Fri, Jan 10, 2025 at 04:52:08PM -0800, Howard Chu wrote:
> > > > > > Hello Arnaldo,
> > > > > >
> > > > > > On Mon, Dec 23, 2024 at 11:40 AM Arnaldo Carvalho de Melo
> > > > > > <acme@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 23, 2024 at 04:02:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > > > On Mon, Dec 16, 2024 at 11:58:46AM -0800, Namhyung Kim wrote:
> > > > > > > > > On Sun, Dec 15, 2024 at 11:07:09AM -0800, Howard Chu wrote:
> > > > > > > > > > Changes in v4:
> > > > > > > > > >  - Use if -f to check the existence of vmlinux BTF, and exit if it
> > > > > > > > > >    doesn't, so trace_test_string will not overwrite $err, and keep
> > > > > > > > > >    running the test.
> > > > > > > > > >
> > > > > > > > > > Changes in v3:
> > > > > > > > > >  - Add vmlinux BTF check, and skip the tests if it doesn't exist
> > > > > > > > > >
> > > > > > > > > > v1, v2:
> > > > > > > > > >
> > > > > > > > > > The previous version of the perf trace BTF general augmentation tests
> > > > > > > > > > didn't pass Shellcheck (thanks to Arnaldo Carvalho de Melo
> > > > > > > > > > <acme@kernel.org> for pointing this out), this version uses bash instead
> > > > > > > > > > of POSIX shell to pass Shellcheck.
> > > > > > > > > >
> > > > > > > > > > This patch series also adds documentation for the new option
> > > > > > > > > > --force-btf, which is used in the tests.
> > > > > > > > > >
> > > > > > > > > > Link: https://lore.kernel.org/linux-perf-users/Zt9yiQq-n-W6I274@x1/
> > > > > > > > > >
> > > > > > > > > > Howard Chu (2):
> > > > > > > > > >   perf trace: Add tests for BTF general augmentation
> > > > > > > > > >   perf docs: Add documentation for --force-btf option
> > > > > > > > >
> > > > > > > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > > >
> > > > > > > > Thanks, applied to perf-tools-next,
> > > > > > >
> > > > > > > It fails when running in parallel mode, sometimes:
> > > > > > >
> > > > > > > 109: perf trace BTF general tests                                    : FAILED!
> > > > > > >
> > > > > > > Then:
> > > > > > >
> > > > > > > root@number:~# perf stat --null -r 10 perf test "BTF general"
> > > > > > > 109: perf trace BTF general tests                                    : Ok
> > > > > > > 109: perf trace BTF general tests                                    : Ok
> > > > > > > 109: perf trace BTF general tests                                    : Ok
> > > > > > > 109: perf trace BTF general tests                                    : Ok
> > > > > > > 109: perf trace BTF general tests                                    : FAILED!
> > > > > > > 109: perf trace BTF general tests                                    : Ok
> > > > > > > 109: perf trace BTF general tests                                    : Ok
> > > > > > > 109: perf trace BTF general tests                                    : FAILED!
> > > > > > > 109: perf trace BTF general tests                                    : Ok
> > > > > > > 109: perf trace BTF general tests                                    : Ok
> > > > > > >
> > > > > > >  Performance counter stats for 'perf test BTF general' (10 runs):
> > > > > > >
> > > > > > >              2.148 +- 0.293 seconds time elapsed  ( +- 13.63% )
> > > > > > >
> > > > > > > root@number:~#
> > > > > > >
> > > > > > >
> > > > > > > So its not just when running in paralell, anyway, its merged, we can go
> > > > > > > on from what we got there.
> > > > > >
> > > > > > It never fails on my machine, I think the reason is my machine is not
> > > > > > fully-loaded. Can you please run
> > > > > > ```
> > > > > > perf stat --null -r 10 perf test -vv "BTF general"
> > > > > > ```
> > > > > > And provide the output?
> > > > >
> > > > > root@number:~# grep -m1 'model name' /proc/cpuinfo
> > > > > model name    : Intel(R) Core(TM) i7-14700K
> > > > > root@number:~#
> > > > >
> > > > > root@number:~# perf stat --null -r 10 perf test -vv "BTF general"
> > > > > 106: perf trace BTF general tests:
> > > > > --- start ---
> > > > > test child forked, pid 47824
> > > > > Checking if vmlinux BTF exists
> > > > > Testing perf trace's string augmentation
> > > > > String augmentation test failed
> > > > > ---- end(-1) ----
> > > > > 106: perf trace BTF general tests                                    : FAILED!
> > > > > 106: perf trace BTF general tests:
> > > > > --- start ---
> > > > > test child forked, pid 47842
> > > > > Checking if vmlinux BTF exists
> > > > > Testing perf trace's string augmentation
> > > > > String augmentation test failed
> > > > > ---- end(-1) ----
> > > > > 106: perf trace BTF general tests                                    : FAILED!
> > > > > ...
> > > >
> > > > I also see the failure on not fully-loaded machines (both Intel and
> > > > AMD).
> > > >
> > > >   $ sudo ./perf test -v BTF
> > > >   --- start ---
> > > >   test child forked, pid 525025
> > > >   Checking if vmlinux BTF exists
> > > >   Testing perf trace's string augmentation
> > > >   String augmentation test failed
> > > >   ---- end(-1) ----
> > > >   106: perf trace BTF general tests                                    : FAILED!
> > > >
> > > > Thanks,
> > > > Namhyung
> > > >
> > >
> > > Just wondering, did you and Arnaldo apply this patch:
> > > https://lore.kernel.org/linux-perf-users/20241213023047.541218-1-howardchu95@gmail.com/
> >
> > I don't think we applied it, will add to perf-tools.
> >
> > >
> > > This seems to solve the problem for me...
> >
> > But I'm not sure if it fixes the problem.  IIUC the patch fixes the
> > loading problem.
> 
> Yes. However, if the machine is unable to load the BPF program, the
> error message will be:
> 
> perf $ sudo ./perf test general -v
> --- start ---
> test child forked, pid 173990
> Checking if vmlinux BTF exists
> Testing perf trace's string augmentation
> String augmentation test failed
> ---- end(-1) ----
> 106: perf trace BTF general tests                                    : FAILED!
> 
> Which is indistinguishable from an actual string augmentation error
> that has a string mismatch...

Ok, that's not good.

> 
> > And for some reason, I don't see the problem any more.
> > But I remember this sometimes happened in the past.
> 
> Do you mean that perf trace breaks occasionally? This sounds urgent.
> Could you please provide me with your kernel version and Clang
> version? Thank you very much! :)

Yep, sometimes it works and sometimes it failed to load the BPF.

The kernel version of this laptop is v6.10.11 and clang version is
16.0.6.

Thanks,
Namhyung

