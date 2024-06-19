Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD71848;
	Wed, 19 Jun 2024 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822082; cv=none; b=KXFuIXDuc9yLim6tKvFqotIGAnHY5cwcd0y8DmhtwNsieJUxmwTZJFWN9aAmSVc0lGs1T8pko3XylYw00RGTGld/HX7Yikarm/lgsknz2Hb9iFHHBvckv7jJTVtGTgE8ftxbrwwUqYUZCQLNfP1wgkDarsp2nzsoT9P9a/vScww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822082; c=relaxed/simple;
	bh=aYq8ts7r2hqXTEgmYmj2kRfmaCSGl9nv/6MI1VsrbPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZWkLU1sXoAmgfhf1wOtEQoAG/uTjyn30JPWNoilzVM35wAh3JYlV+0j37rw3FO3X+LahjgICNwgUTcriYBae/CcNNTzm95KsKjGukHQ10XdBWlKisqz/b77TGNT2Iw4yus5ZENGnEQEUyNfjCPEkIGKIb1yN3qPoveVqQdFS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c7bf925764so124664a91.0;
        Wed, 19 Jun 2024 11:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822080; x=1719426880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxySTycZsV5/gu9Q2STkld6/1Kd4spXPuJywcLrjDw0=;
        b=azqYkS+vyF1tNbqxXctkhvxJnSacS61H90W1EiKVPydT7wcKAw4vpUOcjZIdddwm8Q
         tWZKbbm7YK09r2zk19u2kDwUAgQyvoGxjXIIkbljeLiIrBXoTb1mxLJVPBXvPF+6HDFZ
         C/kZ5IvzGxPTZ8tId6X0XwpecWyQIPqM1VFIisqoY+jS4Ayqow2q8dbvModYI2kpgB17
         xcHBQkFGjHZKIVM1aqP6DtWfJQ8Bdd7E5z7vNl0Z7Nx44Es2004ZOqqdwDCcRyZ0Wfby
         1qh0s3pwfBeMMir62VY5rie1pJCtl6x8+6OTV1unukGLihLdyZ+fl9pKatNxKKyVs3tw
         rpfw==
X-Forwarded-Encrypted: i=1; AJvYcCUyCGZy7WKODhsyAXJXG7j9XYL+cshJR9kWOJFlPHEAoqcg1X+q3UlJdT8oP9SyFfw8qoKc4BlgORI6qn1ibNHUuO3Ee3gV9SpjLTereku14MYSHzWG635wsO9ULLfYfDlAJ2yW83IT6dyLnVVLUA==
X-Gm-Message-State: AOJu0Yx3OleJEDs7/Sh0wtvuW7Jz9n8p+lM75+8Wto0LBBvG94mn5IYi
	K2DehRS0ouUh3j8wrZ6jBC8i4ZT2kryef0RBCJ/wxE5C8r2gTxDeCgupYnzaqQfHIiJAyqcetK5
	rYb+JMSKcvjIDArBcnToQ2HgS8Yg=
X-Google-Smtp-Source: AGHT+IGflNTYqNvfUrwzj5dURA9uEGLLubwGlo5ntHYvn/Px4PEA3BmGfCoXDuPCbfqwk8lS+0I/TYLrTtitt+xeFng=
X-Received: by 2002:a17:90a:9c6:b0:2c7:aba6:d32f with SMTP id
 98e67ed59e1d1-2c7b5c8a1b1mr3335068a91.22.1718822079910; Wed, 19 Jun 2024
 11:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406181535.eacba363-oliver.sang@intel.com>
In-Reply-To: <202406181535.eacba363-oliver.sang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 19 Jun 2024 14:34:28 -0400
Message-ID: <CAM9d7cgDUQL82ToJN5kXJpdEm0aTEJmU1iuxCwSK5Vhi2jnpPQ@mail.gmail.com>
Subject: Re: [linux-next:master] [perf test] 658a8805cb: perf-sanity-tests.perf_annotate_basic_tests.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 18, 2024 at 3:54=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "perf-sanity-tests.perf_annotate_basic_tests.fa=
il" on:
>
> commit: 658a8805cb604260ae9f35ae5e50012e3d1ed5e3 ("perf test: Speed up te=
st case 70 annotate basic tests")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master 6906a84c482f098d31486df8dc98cead21cce2d=
0]
>
> in testcase: perf-sanity-tests
> version:
> with following parameters:
>
>         perf_compiler: gcc
>
>
>
> compiler: gcc-13
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake)=
 with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> we didn't observed the issue on parent.
>
> f5803651b4a4b67d 658a8805cb604260ae9f35ae5e5
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     perf-sanity-tests.perf_anno=
tate_basic_tests.fail

Hmm.. strange.  The only change in the commit is to save
the output of perf annotate into a file.  I'm not sure if it'd affect
the test result.  Maybe because of sanitizers..?

Thanks,
Namhyung

>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202406181535.eacba363-oliver.san=
g@intel.com
>
>
> 2024-06-14 20:09:34 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-658a8805=
cb604260ae9f35ae5e50012e3d1ed5e3/tools/perf/perf test 76
>  76: perf annotate basic tests                                       : FA=
ILED!
> 2024-06-14 20:12:46 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-658a8805=
cb604260ae9f35ae5e50012e3d1ed5e3/tools/perf/perf test 77
>  77: Add 'perf probe's, list and remove them                         : Ok
> 2024-06-14 20:12:46 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-658a8805=
cb604260ae9f35ae5e50012e3d1ed5e3/tools/perf/perf test 78
>  78: build id cache operations                                       : Ok
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240618/202406181535.eacba363-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
