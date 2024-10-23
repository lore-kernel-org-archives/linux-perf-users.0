Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA315746E
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720483; cv=none; b=YwVBMco/8fb96FI31GLEWIjcrJxSYCoFUJmAnwFwJgcWUaxR4NYWAX51WWb4BmNTENIYb/48Kaz0W6XOalfPOghFV1PKvbGv5//dTZTpSUOtvP249czuOrJptnrzOIyJb/lbiE86ObXIsPdnUpm2fmtsP6+7Y9MVwdHQVjyQqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720483; c=relaxed/simple;
	bh=lmUKdBaSK9Dkw8Liv4b4VF+Tp+oQ/1cq+++uASlnThs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7ap9D16K0gQEDLYs19uD42EpvK/Qkl5gpUfBJ1D8uocrEPybQVKkP4aDXbT+3rDxTNXGi1Y1EepabhqulhTa3Co/UXN9JPDorbYEdEb0+omX9HQJh5CwLEI4+oTKuoiW8r6wLAHmXwyp58W/pKfor9F5WyNt29sqcPH8JJ/j1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvLn+ZQd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvLn+ZQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707F3C4CEC6;
	Wed, 23 Oct 2024 21:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729720482;
	bh=lmUKdBaSK9Dkw8Liv4b4VF+Tp+oQ/1cq+++uASlnThs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvLn+ZQdnVM04TDzsrzD8eppBLllufXu305pS251/WiOf2fX01E8gSP/HxVD9rrHr
	 vZ8Y4iTZPjlAcG6wJaLvnepxe+jFW9z4IKAWUYUxJjTQAAGCUERvwZ6UA1wkjw9+up
	 +PQ6FZuwXpSZGQcLfrPndzjGJPmo6dpRHXA7IocokecL/gv62ZqV/JAPZURwSyQVBb
	 OyW6UmRa3nx42EIW0XeTzdbungseRg3pgNBi4CrIpSbqaP9X5lYKodYTxQPJjtls6Z
	 QJ441lUyEYIEPHIj+mtd+jjs3tM9MU4cCdx0nGe363c1XQv5hK/dJestfiND08ZlJK
	 3o4ISI+MDrC1A==
Date: Wed, 23 Oct 2024 14:54:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yunseong Kim <yskelg@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
Message-ID: <ZxlwoN57PF_5YX0F@google.com>
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
 <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
 <20241011-uncovered-original-vole-cda87d@meerkat>
 <20241015-warping-condor-of-storm-afa06f@meerkat>
 <Zw8cN9daNBvCJd3u@google.com>
 <CAP-5=fXsVXYkncR0rwxXvKp_f5dR40L9_x-qoLxwHXWMiyXh3g@mail.gmail.com>
 <a0626ecb-cc64-4c6a-abf3-76868178234f@gmail.com>
 <b1c1a76b-5094-4384-9304-360a6012e3ad@intel.com>
 <b11407cf-8cfe-40ec-abe7-165122807e1d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b11407cf-8cfe-40ec-abe7-165122807e1d@gmail.com>

On Thu, Oct 24, 2024 at 03:17:38AM +0900, Yunseong Kim wrote:
> Hi Adrian,
> 
> On 10/24/24 2:34 오전, Adrian Hunter wrote:
> > On 20/10/24 07:49, Yunseong Kim wrote:
> >> I would like to express my sincere gratitude to everyone for their help in the
> >> official renewal of the perf wiki.
> >>
> >> Additionally, the reason I chose to use Markdown is that I wanted to actively
> >> utilize its media features. For example, I wanted to embed videos,
> >> presentation slide or display Mermaid diagrams directly on the page.
> >> I thought these features would be welcomed by users who are new to perf tools.
> >>
> >> On 10/19/24 8:47 오전, Ian Rogers wrote:
> >>> On Tue, Oct 15, 2024 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >>>> On Tue, Oct 15, 2024 at 02:25:02PM -0400, Konstantin Ryabitsev wrote:
> >>>>> On Fri, Oct 11, 2024 at 06:39:09PM -0400, Konstantin Ryabitsev wrote:
> >>>>>>> Yunseong created:
> >>>>>>> https://perfwiki.github.io/main/
> >>>>>>> Perhaps the solution here is to make perf.wiki.kernel.org a redirect
> >>>>>>> to https://perfwiki.github.io/main/
> >>>>>
> >>>>> To speed things along, and since the old perf wiki was near-unusable anyway,
> >>>>> I went ahead and set the redirects from perf.wiki.kernel.org to
> >>>>> perfwiki.github.io.
> > 
> > Links to old pages end up at the main page.  For example:
> > 
> > https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
> > https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
> > 
> > Any way to get them to redirect to the correct page?
> 
> We can use web.archive.org as of September 30th of last month.
> 
> Intel PT Link:
> https://web.archive.org/web/20240930185823/https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
> 
> Top-Down_Analysis Link:
> https://web.archive.org/web/20240930164757/https://perf.wiki.kernel.org/index.php/Top-Down_Analysis

The corresponding pages in the new site are:

 https://perfwiki.github.io/main/perf-tools-support-for-intel-processor-trace/

 https://perfwiki.github.io/main/top-down-analysis/

Thanks,
Namhyung

> 
> 
> >>>>> Please feel free to follow up if we need to revisit this, but things look good
> >>>>> to me with this change.
> > 
> > Do we still have the old pages?  I would like to check that the Intel PT
> > page is not missing anything or munged.
> > 
> >>>>
> >>>> Thanks for your work, it looks good to me too.
> >>
> >> I have been continuously improving the content of the documentation, so please
> >> feel free to share any good ideas you may have. :)
> >>
> >>> Thanks Konstantin and Yunseong, I think it looks good!
> >>> I think the pages need some improving, there are empty pages and
> >>> things that look abandoned, such as the white paper linked from the
> >>> side bar:
> >>> https://perfwiki.github.io/main/white-paper/
> >>> I pushed a few improvements to the glossary and useful links. It
> >>> should be as easy as creating a pull request for others to contribute,
> >>> so I look forward to this.
> >>
> >> Thank you so much Ian, I added per-page editing features to make it more convenient
> >> for people to edit the documentation and submit pull requests.
> >> Link: https://github.com/perfwiki/main/commit/4289b6a6e5c2e53d69a7605d01d0773366a33c52
> > 
> > I do not understand.  Is it a wiki anymore?  If so, what is
> > needed to edit a page?
> 
> If you need to update the page directly, I can grant you permission to
> do so. This is similar to the previous login system based on Media Wiki.
> 
> The issue with the old wiki was that logging in was broken(sadly) for
> several months.
> 
> > Also how can page updates be submitted programmatically?
> 
> You can submit a Pull Request or if you have the necessary permissions,
> you can directly update the document to add changes to the main branch.
> 
> > I had a script auto-updating the latest man pages, using
> > MediaWiki API, which I will have to redo :-(
> 
> Could you let me know what script auto-updating you were performing with
> the URL of the API or the specific functionality? If there is anything
> else you need, please feel free to let me know. I will do my best to
> assist you.
> 
> Best regards,
> Yunseong Kim
