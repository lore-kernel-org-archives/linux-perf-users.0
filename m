Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDC2C19F2A
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Aug 2022 12:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiHDMqi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 08:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiHDMqi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Aug 2022 08:46:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FDA64D4
        for <linux-perf-users@vger.kernel.org>; Thu,  4 Aug 2022 05:46:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h13so5892250wrf.6
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Aug 2022 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=giKnKISVMAsiPJX3VXxs0ynsiTBqVt8j9JEnvT2UxBg=;
        b=NbKDBV0VtJxC9+FNETy4s7gG8mMWd5uQAdfb3VE1dBX6yaShZ9A9l2fxAmWOcWmndb
         /ftQOBlSBY5eEiltNl2u4MAgE63PcB63fiABeYpWMDClFcdV5Q9POCg4I24TkeSLotqx
         PA3RSAtnfCnUyDQ0Eim+vMJtbQG4eWtQIRRctb13apb/w87DgZ1bBzsBG39bzI+SKBPA
         w7WNSemTshELz7+uesOPT08oQrmAlFl0LJ1OCo9vs9bzsbrAAwaxpblwnu8KBQzsiQkd
         ynWKsCcS1jWMHuxm/rhGpgRUEg0arLpENoQK/tcV2SdTLRaJ0c/1TyLWbQh6YUpL7tnu
         gYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=giKnKISVMAsiPJX3VXxs0ynsiTBqVt8j9JEnvT2UxBg=;
        b=qMveFqA3sncAQAtnXFA/9545nDHk44252sFZZHlJ1Ujn7tS1gQt+MR6mgbDlem3Rwu
         NLLlm0cgDJVh3CoEW/ZviHzuMHsL3GLPmXNA5uh30XfjAlj7cWMvdcrfl7eJaoFHcmM/
         X4116HXPSWWfCdrRvCbcPKK+5PP3P48w9e8l94sxZAai/lMjZgkwQkTKmzi8Nb9mkvTz
         tPjW63hWnL72MGriRqVi0f83+azMkoZeyoCDGzNiDTxucdSJ5IuPIeUOjzxF++G6/5Ar
         09lsdEWJqO6/X2+iyUNlIQMhWfTBpiE/sQcWSbmmi/SfNz7GwwijkibEmVgAnRmIB8Pf
         274g==
X-Gm-Message-State: ACgBeo2GL0IZteMOyc8PCqJA3dOnuuRdxS4zl+Z56lfrzrdLOcjtaG06
        N15kUV47euFKITBn6t9zjqx21bXhmxs3X1N9J6s=
X-Google-Smtp-Source: AA6agR6vS/KrcB1Xy05KjWQYf2qwHWqw500M9jCO18rJYncM0MXptB9QBm3Xg0NbQnIapY+h9sTj3g==
X-Received: by 2002:a5d:560d:0:b0:21f:1619:ba0 with SMTP id l13-20020a5d560d000000b0021f16190ba0mr1344504wrv.318.1659617195318;
        Thu, 04 Aug 2022 05:46:35 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([167.71.129.183])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bce08000000b003a4f29d6f69sm6741668wmc.36.2022.08.04.05.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 05:46:34 -0700 (PDT)
Date:   Thu, 4 Aug 2022 20:46:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 01/14] perf test: Refactor shell tests allowing subdirs
Message-ID: <20220804124629.GB1219098@leoy-ThinkPad-X240s>
References: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
 <20220712135750.2212005-2-carsten.haitzler@foss.arm.com>
 <20220713065328.GB1354743@leoy-ThinkPad-X240s>
 <b6798d9f-2d81-2a39-1406-9b9770b016ae@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6798d9f-2d81-2a39-1406-9b9770b016ae@foss.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 28, 2022 at 03:17:08PM +0100, Carsten Haitzler wrote:

[...]

> > > +	}
> > > +	/* Realloc is good enough, though we could realloc by chunks, not that
> > > +	 * anyone will ever measure performance here */
> > > +	files_tmp = realloc(files,
> > > +			    (files_num_tmp + 1) * sizeof(struct script_file));
> > 
> >          files = realloc(files,
> >                          (files_num_tmp + 1) * sizeof(struct script_file));
> > 
> > BTW, I don't see any where to free the memory for "files".
> 
> The very first comment at the top of the code (after headers) that you
> wanted the format of changed explains this right above the static vars.
> There is no point. This is code for a utility that runs tests and runs them
> once ever and then exits. There is no need for a cleanup/free as it's all
> freed on process exit. It's a singleton design pattern so it scans for these
> test files once ever for the whole run of the tests (unlike before it'd scan
> multiple times with all the I/O overhead and syscall costs).

Okay, I understand your meaning.  But I still think that it's not a
good practice if program doesn't explictly release memory.

I will review new patch and check if we can release the buffer in
somewhere in the code.

> > > +	if (files_tmp == NULL) {
> > > +		pr_err("Out of memory while building test list\n");
> > > +		abort();
> > > +	}
> > > +	/* Add file to end and NULL terminate the struct array */
> > > +	files = files_tmp;
> > > +	files_num = files_num_tmp;
> > > +	files[files_num - 1].dir = strdup_check(dir);
> > > +	files[files_num - 1].file = strdup_check(file);
> > > +	files[files_num - 1].desc = strdup_check(desc);
> > > +	files[files_num].dir = NULL;
> > > +	files[files_num].file = NULL;
> > > +	files[files_num].desc = NULL;
> > 
> > I personally think here it's over complex for using the last item in the
> > array as a redundant item and set NULL to its fields.  We have the
> > global variable "files_num", which can be used for checking boundary
> > for the array.
> 
> See how the code is called. It makes the calling simpler as you don't need
> to get both the array and the num/count. You just get the array and iterate
> until a NULL item. So the calling convention is simplified. That's why I did
> it. It's a very common design pattern that saves some complexity at the
> caller end with the cost of a "null item" overhead. Just do ptr++ as you
> iterate over the files until a null item - much simpler calling code.

Okay, this would be fine for me.

[...]

> > I strongly suggest you to consider how to organize the patches with
> > better format.  This patch actually finishes below things:
> > 
> > - Support sub folder searching for shell script (so the key change is
> >    using the recursion in append_scripts_in_dir());
> > - Refactoring to a common code for iterating testing scripts;
> > - Many minor refactoring, like dropping macro for_each_shell_test()
> >    and introduces new function is_shell_script().
> > 
> > Seems every part above is deserved to use a separate patch, which would
> > be much easier for review.
> 
> It was not written in stages at all but wholesale written as a new file to
> replace the functionality in the previous file that was duplicated multiple
> times (scandir). The new code could also recurse too. I'd have to bend over
> backwards to create an artificial new set of code that uses all the old code
> then iterate it multiple times to do this. It's not how it happened.
> 
> It should be drastically easier to review this way as you can easily just
> see the old code vanish and how it now calls the new code (and how simple it
> is) and then the whole new code beng called - review it as new code. :)

Just remind, at the end you need to convince maintainers for the
patches, this is why I suggest you to use small pieces of patches
rather than a single big patch. :-)

My personal experience is small chunk patch is much easier for review.
Anyway, I will review the new patch set.

Thanks,
Leo
