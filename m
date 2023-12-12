Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7xZKCyu"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6434AAF
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 04:11:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so42048215e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 04:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702383105; x=1702987905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vvX/7Y3iddJPyfypuEZXnIiZpYWEQ7CUvnOeW0zgN7I=;
        b=M7xZKCyuZAbPmMSJoBNIFr90oc699iG26kEN9wzMF6hMSob8irmS/2UsLwD3Yvp9x9
         SmtcSR8HixMr1jmgkvCbgE00UAxrWXpPSzyPDW8mJI+ZlEDdTVvXJ3Ag1m/8BE2NX2ys
         wwJ04qiCJccbMSjGOG2DKKo+sE4E6fjBiXTAkjRSBr2Rnw2z3jDJqZXnIi/Ze505tcWm
         DfQGiktGJA1XKSTUr6jo8uutiNTLwtujP///rt6VvUN/NXM6/T5Bc2sDn5nq4T39ANLJ
         n7/NxjK+62YXfNlUUUtYrx1RdVkRmBRWKToI/oPBrY4jVf3ziCxnLmNZra5bQZeUJknh
         DZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702383105; x=1702987905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvX/7Y3iddJPyfypuEZXnIiZpYWEQ7CUvnOeW0zgN7I=;
        b=RUWfRMpDBoCClk/0hje4+Zzc2+Lb1PobFoRl81qCjLa0tpR9rulG5cRg0ilrWSszWv
         DTaXhDWggu2h6p+uRB0p/wBy5jL4L7Y0jIuYcn3tqGxr7MS/0kA8MsZkfzxG9j/tonYf
         M8BJSMjvGxCZxr8voHwpC4j6Eh/OO6767WZ4iySeBGuRv5A+zzRvSQbPc/yFt7XtbHcX
         6mU7ZXxkf7za07Kn3MQlHzLEKtUrapu8Zyc4RKCwsv/O6D4ODRxJ4dBCz4Iz4tOhfccG
         BW99CJma6IlcCEow7GsskgQVg26qZknHArINMyF5g2LJQQVeA3lckep+Ok7Ty57ubxFd
         vMGQ==
X-Gm-Message-State: AOJu0YyEmFdnDNO+xrv/A2RpyFEK++yU8CknjmtF0FLg1RovIjPpkauB
	QlbLl/Ue19zA/YmqHKj+2QS7Ru7LsrU=
X-Google-Smtp-Source: AGHT+IGpn85MjCdEVJ3q5O2h564s2WHZin9K6QlUzQUZ8K9tMctCCvzoWUnffWqCIqP48I/UQnj/1w==
X-Received: by 2002:a05:600c:1913:b0:40c:366a:598a with SMTP id j19-20020a05600c191300b0040c366a598amr3412196wmq.107.1702383104464;
        Tue, 12 Dec 2023 04:11:44 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm18504231wmo.16.2023.12.12.04.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:11:44 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 12 Dec 2023 13:11:42 +0100
To: trinity pointard <trinity.pointard@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: possible regression in perf
Message-ID: <ZXhN_j8UShp1JAlf@krava>
References: <CANiTRwdm56EJkY=HN+OnD1y++MT6zxEpX3dqoThELMRsUyFTEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiTRwdm56EJkY=HN+OnD1y++MT6zxEpX3dqoThELMRsUyFTEw@mail.gmail.com>

On Mon, Dec 11, 2023 at 07:00:51PM +0100, trinity pointard wrote:
> Hi,
> 
> I think I found a regression in perf related to the control fd.
> At its introduction (bee328cb71eb0b38ab128d7c475209d973a13f92), it
> looks like enabling or disabling counters would print the current
> counters. However when `enable/disable <counter>` was introduced
> (991ae4eb36911fe9a99bef1c22b9578ceec3896a), it changed what
> `evlist__ctlfd_process()` would return on a successful enable/disable,
> which made the call to `process_interval()` in `process_evlist()`
> essentially dead code.
> 
> I was in the process of patching perf so that `snapshot` would print
> current counters (in which case I would send enable, sleep a bit, and
> send disable+snapshot, to do my measurements). But given what I saw, I
> think just sending enable and disable was enough at one point.
> 
> Is this a known issue? Would a patch which makes
> `evlist__ctlfd_enable()` return 1 on success be an acceptable fix?
> It's somewhat more verbose than what I wanted initially (printing both
> on enable and disable, printing on enable isn't useful to me), but
> that's reasonably easy to post-process (or enable could be made to not
> print current counters).
> 
> Regards,
> trinity-1686a/trinity Pointard
> 
> P.S.: this is my first time posting to LKML, please tell me if I did
> anything wrong :-)

hi,
thanks for the report, could you please send proposed change as patch
and steps to reproduce the issue?

jirka
