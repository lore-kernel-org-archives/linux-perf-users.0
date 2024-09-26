Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6E19D897
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727389990; cv=none; b=hktfyO950u8MpMle7WF6+a5kXvyikVCcQcRtnx1mdTdVXL2F7vZaE7+0JcdI9r2Fnkdf4o+t/qwnsWMs+XluV04Ii6ZsSMzb4bef8nCSWJAQP8X/qSDQiv7sZodC6RtoU47N0pN+d7QWSvaAgA2KAyvhPzzJDn5K1R/mq2Kw0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727389990; c=relaxed/simple;
	bh=s4zyF4OfVD3z8cn9ovlUe94sCo7G/RLgythbHZDr+MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvhZvX9Csf3atj2JErgVqcgrcj8j5oL9CTDRI6dluCTyzwE6LDM/rwhbfOdvC6MFyaJdGy5iURpj9i8VY10MWpKqw9FJtH1CNNFsM2RfAkQgk4q7ykxeDsTL4Yljr5NQ7qJIgIoJRRw7CKLw9OG9dJAeu1DnwsSrv4VS5Z1MA6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RX9DLw0J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX9DLw0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1FBC4CEC5;
	Thu, 26 Sep 2024 22:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727389990;
	bh=s4zyF4OfVD3z8cn9ovlUe94sCo7G/RLgythbHZDr+MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RX9DLw0J1JPkQrVZwBp7bjB49agfSxq/jDQLmyFM8O9o2sYd2fMkSMp9Py1fPRN/J
	 vfm16s0zwrNe7vb7NftQI0CQ4OxnpckVGxhtt8iCNbOSU7mLV3gxkGCQ2nSZMvM80x
	 S407TNXPK4VdM73DQYNSSLqhVdoLzQ959KziO8UiapZEgwiMd6KoI2erOVj0JKOqQG
	 9Y6oww/yOb5tq2ZAex+80+IUkuSC7E/dYocmaIGE/z/makkH3eJqEFtqkcFwzHz80D
	 t0eWxmgyRnW1addAH+ENakDZxoExR5gjE1vp4Qx8YeG31iR/n7navZgWYhMDDJjnmS
	 hiRBwGg4fe4Fw==
Date: Thu, 26 Sep 2024 15:33:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, acme@redhat.com,
	mpetlan@redhat.com, irogers@google.com, atrajeev@linux.vnet.ibm.com
Subject: Re: [PATCH v2 00/11] perftool-testsuite 2nd batch
Message-ID: <ZvXhJLkJcR99Y2sF@google.com>
References: <6b8245be-7fbf-41e9-8622-f8990ae7a880@redhat.com>
 <ZtXMRffIGVmjptcf@x1>
 <ZtXOrJdxvrI7Kk6n@x1>
 <b87e2c58-8696-48bc-92ca-93964917bf9a@redhat.com>
 <ZtYIElLzMIzEVH9t@x1>
 <20240906001104.9314082caaf0268f09cc45b2@kernel.org>
 <ZtoAuoFNF8neYA-4@x1>
 <ZtoDUPuP-fEbC6sg@x1>
 <ZuLnhbC4eAmKzVO5@x1>
 <064825c4-7c5d-425c-b3be-dd20a593aca1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <064825c4-7c5d-425c-b3be-dd20a593aca1@redhat.com>

On Thu, Sep 19, 2024 at 03:14:40PM +0200, Veronika Molnarova wrote:
> 
> 
> On 9/12/24 15:07, Arnaldo Carvalho de Melo wrote:
> > On Thu, Sep 05, 2024 at 04:15:28PM -0300, Arnaldo Carvalho de Melo wrote:
> >> On Thu, Sep 05, 2024 at 04:04:29PM -0300, Arnaldo Carvalho de Melo wrote:
> >>> So, I proposed that if we get that error message (A function DIE doesn't
> >>> have decl_line. Maybe broken DWARF?) we should skip it, but Veronika did
> >>> the right thing and asked if that wasn't really papering over some
> >>> problem and pointed to a patch that addressed a problem that lead to
> >>> that exact same message being produced, but that didn't help with our
> >>> current case, with another blacklisted function, warn_thunk_thunk.
> > 
> >>> You mentioned that this is an asm function, so no DWARF, let alone
> >>> correct DWARF, so the message is kinda ok, but we can't use that message
> >>> as it could paper over real problems like the one fixed by the patch
> >>> that Veronika pointed out.
> > 
> >>> How to figure out if a function has valid DWARF? Maybe for the moment we
> >>> should have _another_ blacklist, one for functions in the blacklist that
> >>> have no valid DWARF? A blacklist's blacklist?
> >  
> >> We have the needed info to provide a more informative warning:
> > 
> > So, perhaps we should, in the test, when we get that "broken dwarf"
> > output, look at the debuginfo file for the kernel to see if the function
> > is one in a DW_UT_compile (CU) that has 
> > 
> >      <da27a>   DW_AT_language    : 32769 (MIPS assembler)
> > 
> > And then just have a -vv output stating that that function is being
> > skipped because it is DWARF from assembler?
> > 
> > Veronika, would you be willing to try to do that?
> 
> Okay, I can try to parse the debuginfo to check the DWARF.
 
I'll wait for v3 then.

Thanks,
Namhyung

