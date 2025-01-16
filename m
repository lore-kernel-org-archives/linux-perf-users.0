Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C473625A635;
	Thu, 16 Jan 2025 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070927; cv=none; b=ex4XzL+k8cbVWpY1b4idY0bhsVUa8s8m+bXnvip/MysQGM7hY+9DKbAISl+cUN8Nmd5LNu+HPs/zLt3BBnybRYwDVh/oXYZtnK1MIMvWhanjHn8vK3KR4eflvoNCgB7JroiErj92WEnxufneyGyXKh6O5+4thtmsypOSOeUV5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070927; c=relaxed/simple;
	bh=XIndIxxeTK1Jrv1AnmUGp4ducNT2bmkAd3UQ6KJUsz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQoukj6fwIqTWQdHsjbFbKhWw55ASdnQ9MaLKclFAP64EBJLMlmQhHjGAgO29YtlvSL5+hWzyNhDisbsQkVZLiKyEL90fa2ywPPZL6MA+w4pomhbYcsqZhVUiSgBxtbarJsxOB0Cg3YFXhPe6XX6anFdTqBHTGGEb9THaLMYXYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso2099562a91.2;
        Thu, 16 Jan 2025 15:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737070925; x=1737675725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frH/z83xuzzJ+sLkN+vbop0iXUiR1IRScbu8SP9GgrU=;
        b=dHfCxL1nFjJi7Ylnp65vELzx1OiNyp9dSEO3kdCam91oAAKUICFpIq22vfPAWBL+ud
         oDb/kQVTMQ8q3uszYXtRwn9ttlphh1qHpehRwS1F7U5ZBQuxpioL9akiwPIGf+Y8Ol72
         CdmchSd0RDAWeDaObcRNsyG7OtpGx0f1lfg+ia2b3Fn/eQecazw2AHOmuZ1MCSrUgUQj
         1MdgfMLLDCnBDC4Z0wntwNYYRUnRMngU+pBfyJg67jGI+S4lDusbyQWxC2QfCEhyeizp
         m0Vdu2a5lMzZOFkXFKEl+n6bQcQ6koh33opC4M8XA0jF1N2iadVxzqSTCkYUs3em46rc
         SMjA==
X-Forwarded-Encrypted: i=1; AJvYcCVX0p660JJ67TWywvm9yHD0Cf69HJzoImPHawL5vStYZYgy4eMaemb1LOD5QrNNvmgkGZxY0kaUbT7wVRu4sAuZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwPC7HfXc+zcPxnjM5HEfE82mJK75oIC4X6b1AQUuO5uHtvVr42
	Vk7wZ8Y1S7oCpd1ixAihM78cpOHDqxQwRz7KtND2qbjV3QiST5hA+iuypSHepBr9tGBTwxVJphO
	KYvhLVpR0HIIKD6B8BDjeW2mBWYM=
X-Gm-Gg: ASbGncvTyXxHnK7kqBxEjQh1fOvpjoCF3mdFixIYPwEgob0PZGaKO986AwkYfBt3/zY
	IV+OTUJjRoKKVnflWHBdI53Ah4hdf5AYzduWc
X-Google-Smtp-Source: AGHT+IEblePmu0QwHgYfLZoSsZ2m7ZAWRnGu46J1tYsPCXMIOw3cqhpP2RLNzw3pysgokH29DaAuFkcrjc22Fa4JT14=
X-Received: by 2002:a17:90b:270c:b0:2ee:8031:cdbc with SMTP id
 98e67ed59e1d1-2f782d2c9a1mr570181a91.23.1737070924885; Thu, 16 Jan 2025
 15:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210200847.1023139-1-ctshao@google.com> <Z1nkt0F5oPoMZKbp@google.com>
In-Reply-To: <Z1nkt0F5oPoMZKbp@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 16 Jan 2025 15:41:53 -0800
X-Gm-Features: AbW1kvaDiDdLc3wjJOLRmiRMZKTHDcH_uKCT0QIkB0VlHGbjtO6GpwXK4rVO1_Y
Message-ID: <CAM9d7cgWLVqUhf91Z4tNwDt-4LQevB0Qhhad6P-FXRfh0-d8PA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] perf lock: Fix parse_lock_type which only retrieve
 one lock flag
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:17=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Dec 10, 2024 at 12:08:20PM -0800, Chun-Tse Shao wrote:
> > `parse_lock_type` can only add the first lock flag in `lock_type_table`
> > given input `str`. For example, for `Y rwlock`, it only adds `rwlock:R`
> > into this perf session. Another example is for `-Y mutex`, it only adds
> > the mutex without `LCB_F_SPIN` flag. The patch fixes this issue, makes
> > sure both `rwlock:R` and `rwlock:W` will be added with `-Y rwlock`, and
> > so on.
> >
> > Testing:
> >   $ ./perf lock con -ab -Y mutex,rwlock -- perf bench sched pipe
> >   # Running 'sched/pipe' benchmark:
> >   # Executed 1000000 pipe operations between two processes
> >
> >        Total time: 9.313 [sec]
> >
> >          9.313976 usecs/op
> >            107365 ops/sec
> >    contended   total wait     max wait     avg wait         type   call=
er
> >
> >          176      1.65 ms     19.43 us      9.38 us        mutex   pipe=
_read+0x57
> >           34    180.14 us     10.93 us      5.30 us        mutex   pipe=
_write+0x50
> >            7     77.48 us     16.09 us     11.07 us        mutex   do_e=
poll_wait+0x24d
> >            7     74.70 us     13.50 us     10.67 us        mutex   do_e=
poll_wait+0x24d
> >            3     35.97 us     14.44 us     11.99 us     rwlock:W   ep_d=
one_scan+0x2d
> >            3     35.00 us     12.23 us     11.66 us     rwlock:W   do_e=
poll_wait+0x255
> >            2     15.88 us     11.96 us      7.94 us     rwlock:W   do_e=
poll_wait+0x47c
> >            1     15.23 us     15.23 us     15.23 us     rwlock:W   do_e=
poll_wait+0x4d0
> >            1     14.26 us     14.26 us     14.26 us     rwlock:W   ep_d=
one_scan+0x2d
> >            2     14.00 us      7.99 us      7.00 us        mutex   pipe=
_read+0x282
> >            1     12.29 us     12.29 us     12.29 us     rwlock:R   ep_p=
oll_callback+0x35
> >            1     12.02 us     12.02 us     12.02 us     rwlock:W   do_e=
poll_ctl+0xb65
> >            1     10.25 us     10.25 us     10.25 us     rwlock:R   ep_p=
oll_callback+0x35
> >            1      7.86 us      7.86 us      7.86 us        mutex   do_e=
poll_ctl+0x6c1
> >            1      5.04 us      5.04 us      5.04 us        mutex   do_e=
poll_ctl+0x3d4
> >
> > Fixes: d783ea8f62c4 ("perf lock contention: Simplify parse_lock_type()"=
)
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
> > ---
> >  tools/perf/builtin-lock.c | 64 ++++++++++++++++++++++++---------------
> >  1 file changed, 39 insertions(+), 25 deletions(-)
> >
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 062e2b56a2ab..7e36bbe3cb80 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -1591,8 +1591,6 @@ static const struct {
> >       { LCB_F_PERCPU | LCB_F_WRITE,   "pcpu-sem:W",   "percpu-rwsem" },
> >       { LCB_F_MUTEX,                  "mutex",        "mutex" },
> >       { LCB_F_MUTEX | LCB_F_SPIN,     "mutex",        "mutex" },
> > -     /* alias for get_type_flag() */
> > -     { LCB_F_MUTEX | LCB_F_SPIN,     "mutex-spin",   "mutex" },

Hmm.. now I think we need this part to keep it compatible.
Let's have "mutex-spin" in the 'name' as well.

Thanks,
Namhyung
