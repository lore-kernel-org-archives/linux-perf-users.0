Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987AD41A8F;
	Tue, 31 Mar 2026 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939348; cv=none; b=WctkpTS9is6W+IItRVyOGFtGnoiw9H2hRKgJmR9q6VjHqnpaq1ZifPxzDpw5VwkrSPG3xT1AJtuUr+6cfKqNgiLx1cGasU7JBiSRQh91KYhrHKBSLpZbUXhheHZcQOrZ1vpCSQPX2h/7SYkS3K2AFuVXQIRSnE4yl25AtLWuttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939348; c=relaxed/simple;
	bh=QZQ9ZaSkn9ZT3mbwYxMSUfQSe+HSCy8crpQBzQvUJk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYvxtu5BCIPYI0Y63fERZ/92tzODEe2JzY+Ls2vkU3aF+05oPY+0QRgO4bNsvce6amWAth9hQHHpCJbEKggaM9UHcqXpVHOxA1vL8U0L7rPOCn6qrjePTai6I4g0/i+CiG0s0lCOFqX1Kllp5yZ+yedFMczSQ1OOSs/MpW5M6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MislfboX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MislfboX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83029C19423;
	Tue, 31 Mar 2026 06:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774939348;
	bh=QZQ9ZaSkn9ZT3mbwYxMSUfQSe+HSCy8crpQBzQvUJk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MislfboX2a5yR08OM8LOjtnxAJ/iizlxtjYX8MynwY726HmW+pCaD1dPwpPDtQPC0
	 SVeunDkj518Ue8cyMaU8TQSQZuRSuq+6PeakfpjaeTVgNcOm7pcBGL6RVOT8E8T/CC
	 8dtyWCohwie1wG/ucjsRWCcCG2IltrGW1ECqua/WOyrL1X6egwihSnfwAVQri5SgX5
	 RzEPP44jtYMwaOjid6oG6HwH1HnYLBJqJWmWBZ45TMi9GfyMngpYX8USY/AQ2FgJZn
	 CT7Kbo/Z0TKBevgu2v7m9E9KVfcRvWueEvUFmyoAJk8S7QE/VIZ1uAP5bFfejN8DI9
	 INyhMcyFwERgQ==
Date: Mon, 30 Mar 2026 23:42:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Ian Rogers <irogers@google.com>, miguel.ojeda.sandonis@gmail.com,
	a.hindborg@kernel.org, acme@kernel.org, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org,
	gary@garyguo.net, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, lossin@kernel.org,
	ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v1] perf test type profiling: Remote typedef on struct
Message-ID: <acts0fXgsuirBp9G@google.com>
References: <jiwt5mjma2puv7kjbgploxx2l5tankjm4zu2tsa75qkckwnwjk@f7mz5vlvzpjz>
 <20260302235821.588686-1-irogers@google.com>
 <gfdliffsgy4j6q2vrilr6kapy3hczh4udszy4wcba6aal3ado4@hfeqa2eizu5y>
 <kr2bfp43sqatdssmhzpmogs2h27ddbmegvaknxb6by24n2t64h@hv4m5myvswpa>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kr2bfp43sqatdssmhzpmogs2h27ddbmegvaknxb6by24n2t64h@hv4m5myvswpa>

Hello,

On Sun, Mar 29, 2026 at 06:18:52PM +0200, Dmitry Dolgov wrote:
> > On Wed, Mar 04, 2026 at 11:44:16AM +0100, Dmitry Dolgov wrote:
> > > On Mon, Mar 02, 2026 at 03:58:21PM -0800, Ian Rogers wrote:
> > > The typedef creates an issue where the struct or the typedef may
> > > appear in the output and cause the "perf data type profiling tests" to
> > > fail. Let's remove the typedef to keep the test passing.
> > 
> > Yes, makes sense to me, thanks. As mentioned in the previous message, it
> > sounds fishy to me that perf record and perf mem record capture
> > different data type -- I'll try to get to the bottom of it.
> 
> I think I figured it out. To reiterate, the problem was that in my environment
> this:
> 
>     $ perf record ...
>     $ perf annotate --code-with-type ...
> 
> was showing a different data structure for workload_datasym_buf1 (buf vs struct
> _buf) than:
> 
>     $ perf mem record ...
>     $ perf annotate --code-with-type ...
> 
> It turns out that the type_die for this variable was derived differently: for
> "record" it was going through check_variable, for "mem record" through
> global_var__collect. If the type tag is DW_TAG_typedef, check_variable tries to
> figure out a real data type via die_get_real_type, which says this:
> 
>     /**
>      * [...]
>      * If the type is qualifiers (e.g. const) or typedef, this skips it
>      * and tries to find real type (structure or basic types, e.g. int).
>      */
> 
> But the underlying implementation doesn't actually check for DW_TAG_typedef for
> some reason:
> 
> 	while (tag == DW_TAG_const_type ||
> 		 tag == DW_TAG_restrict_type ||
> 		 tag == DW_TAG_volatile_type ||
> 		 tag == DW_TAG_shared_type);
> 
> By itself it doesn't look problematic, but for some reason datasym test was
> producing such a code, that had a chain of two DW_TAG_typedef in a row, so that
> die_get_real_type was returning a DW_TAG_typedef again.
> 
> It looks to me like a deficiency of die_get_real_type, and the following code
> change fixes the problem for me:
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 9267af204c7..de152fae1d9 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -279,6 +279,7 @@ Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
>         } while (tag == DW_TAG_const_type ||
>                  tag == DW_TAG_restrict_type ||
>                  tag == DW_TAG_volatile_type ||
> +                tag == DW_TAG_typedef ||
>                  tag == DW_TAG_shared_type);
> 
>         return vr_die;
> 
> Does this change sound reasonable?

We have this:

  Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
  {
      do {
          vr_die = __die_get_real_type(vr_die, die_mem);
      } while (vr_die && dwarf_tag(vr_die) == DW_TAG_typedef);
 
      return vr_die;
  }

Thanks,
Namhyung

