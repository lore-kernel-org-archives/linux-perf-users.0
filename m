Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195E31986E;
	Thu, 14 Aug 2025 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204123; cv=none; b=HkzUu7kXZkrpd5ZWD2qFEs7Kb5Aht0fOrm7kHRfdGLpXiDxNL4oF9JyYSmRNKlJ4+DYeEHSQWRniaXAz/u+R90Cu33ITNwnLofr+oitosOn9SwxrBg+8bfHi/18ozk3g8SWmtCGd+7wiH0KnYB3oyZA9Av/3muaD7O/FQ7UEQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204123; c=relaxed/simple;
	bh=TvCzjtkjaLNqUYR6A3xtnIpIbwyxrlnjjkYC2IjUKYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU7K52jbAUutDbtyJ4wv1eqwJOCePmF9J6JTul4JIG7KPCls/DKkMM80M/BXipI0tL1RuoqXitdngvoQG2GVUmYJJva1Pgw0qskDGEfFyanxcFuxeLvQfuHoPsFo7W6PKS4VZoXKKc4SRZ3/4yJc/j2q1zVFTwayRwXzLvOz+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyBscmNz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyBscmNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66AAC4CEED;
	Thu, 14 Aug 2025 20:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755204122;
	bh=TvCzjtkjaLNqUYR6A3xtnIpIbwyxrlnjjkYC2IjUKYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyBscmNzmJ/jLs1DkRKYVMZifcxVALZDTck9Oa7U2IzeUS9Np8Q5bCVnmHcvW94Eo
	 PxW+whPKhIAVj+ygzfYjz72ZN5QsRT90ksFd2x4vD0jdb0Z/UuvvXX1Fcov0pbuGO1
	 p7kI69NxUbj9XcZBJoAZde9D2nd5upQDkpRUJuTacYO90NgJJsnwEDodDO4V0m10c8
	 Pb1N2ruq90SvVJvdioSBK2HFiUwsaZ2VL5B7TjjNlGPMebvaMeLcAS/htWhMRpXrJT
	 g4LtcPJJtfZyVEXbTeM6+oeAewRrDZMH42anQFdaneOp675tlQD8abJjY2YTt91D0p
	 ZPPONQEAa8z7A==
Date: Thu, 14 Aug 2025 13:42:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Sergio Perez Gonzalez <sperezglz@gmail.com>, zhaoguohan@kylinos.cn
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, colin.i.king@gmail.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf drm_pmu: Prevent resource leak in
 for_each_drm_fdinfo_in_dir()
Message-ID: <aJ5KGPxzXZtyIO3k@google.com>
References: <20250814060614.450696-1-sperezglz@gmail.com>
 <aJ5HhZsRPN-ZY_cK@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJ5HhZsRPN-ZY_cK@google.com>

On Thu, Aug 14, 2025 at 01:31:01PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Aug 14, 2025 at 12:06:11AM -0600, Sergio Perez Gonzalez wrote:
> > Close fdinfo_dir_fd and fd_dir prior to exit, in the event of
> > cb() error.
> > 
> > Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Just found another fix was posted already:

https://lore.kernel.org/r/20250813033432.8943-1-zhaoguohan@kylinos.cn

Thanks,
Namhyung

> 
> Only a nitpick below.
> 
> > ---
> >  tools/perf/util/drm_pmu.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
> > index 988890f37ba7..416aeac7956e 100644
> > --- a/tools/perf/util/drm_pmu.c
> > +++ b/tools/perf/util/drm_pmu.c
> > @@ -403,7 +403,7 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void *args, int fdinfo_dir_fd, c
> >  	DIR *fd_dir;
> >  	struct dirent *fd_entry;
> >  	int fd_dir_fd, fdinfo_dir_fd = -1;
> > -
> > +	int ret = 0;
> >  
> >  	scnprintf(buf, sizeof(buf), "%s/fd", pid_name);
> >  	fd_dir_fd = openat(proc_dir, buf, O_DIRECTORY);
> > @@ -418,7 +418,6 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void *args, int fdinfo_dir_fd, c
> >  		struct stat stat;
> >  		unsigned int minor;
> >  		bool is_dup = false;
> > -		int ret;
> >  
> >  		if (fd_entry->d_type != DT_LNK)
> >  			continue;
> > @@ -458,12 +457,13 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void *args, int fdinfo_dir_fd, c
> >  		}
> >  		ret = cb(args, fdinfo_dir_fd, fd_entry->d_name);
> >  		if (ret)
> > -			return ret;
> > +			goto out;
> 
> It could be just 'break'.
> 
> Thanks,
> Namhyung
> 
> 
> >  	}
> > +out:
> >  	if (fdinfo_dir_fd != -1)
> >  		close(fdinfo_dir_fd);
> >  	closedir(fd_dir);
> > -	return 0;
> > +	return ret;
> >  }
> >  
> >  static int for_each_drm_fdinfo(bool skip_all_duplicates,
> > -- 
> > 2.43.0
> > 
