Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A91E4B2;
	Fri, 23 Aug 2024 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419053; cv=none; b=rxHpvAIL7d9QsnRs3OArk7ONfLmGK02SkO3c7OycMQCq5m+o+zTswc3IM9siQfQ+tMpsfyOeCWkfEFhSxIprqXhH2fILSGDcQwk/Etbad6dcs2MWsC1x56lriNhEHLuuUljU0ZTAM8xBpUEUaw35FmBAQUPh7U7QuiojWWqfsQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419053; c=relaxed/simple;
	bh=vNOPFnUUgqIZCsZ9G+sLenBXNsMnJqk5VHIKseweeyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCzPpAB5FoJjR249kUHeZWIQ2tEk96tBTUmSWby0pmtFTkkZzHUDahM7VYLRSZPypt8a8ZSg5jEhXR1ZUkhcnpVlLNc83WHRUJSFm9vq/j4w1hWOJyuAhmdoOSStXdxK8DD3sMzlGZi8KETvaTcq2n8sSu4a5nAr0BepXxFCyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM349I3h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM349I3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145B7C32786;
	Fri, 23 Aug 2024 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724419052;
	bh=vNOPFnUUgqIZCsZ9G+sLenBXNsMnJqk5VHIKseweeyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WM349I3hxOfHBiRXpCUUWQs0smPVDvjs3QcgUdyRvavfsFIwCSRiWFynWbqtOhV/t
	 pwgbuz8Mog9kzW5hB9dfRMCO776P/ildh/8V6JcGq4tmkW9mSdfrTplmtbwXClJbxC
	 tThc7RotB4KDJ5Tk9Sx9QAGQw0E6C/kyUJEJq6C8V/biNp7wF/QP+YfvEl/iR4txmT
	 oFlLtSjr6HiK6SYAd8TmQESMKYhVAa4qbhC4E/hfZnQjZzEfytcf/TD0oTxynJioaq
	 VPHwrUcmu5al4Ujo872jvwfcRBGOPfAdp/NRRlt+zohzOtlfJs8NVA5QSugBdabKmW
	 PMIZk0LQbvNcg==
Date: Fri, 23 Aug 2024 10:17:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] perf trace: Add some string arguments' name in
 syscall_arg_fmt__init_array()
Message-ID: <ZsiL6aW-nSxCvYBP@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-5-howardchu95@gmail.com>
 <Zse4LR6gtIO8-Fch@x1>
 <CAH0uvohkLdA5OHWTWqit-6ttd254Sg1vJQBejK+1yzxO7=miJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvohkLdA5OHWTWqit-6ttd254Sg1vJQBejK+1yzxO7=miJQ@mail.gmail.com>

On Fri, Aug 23, 2024 at 12:37:01PM +0800, Howard Chu wrote:
> On Fri, Aug 23, 2024 at 6:14 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Aug 15, 2024 at 09:36:20AM +0800, Howard Chu wrote:
> > > Add them so that we can augment more strings (which is a file path)
> > >
> > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > ---
> > >  tools/perf/builtin-trace.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index e7e8c89d9538..84c7398312d8 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -1918,7 +1918,13 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> > >
> > >               if (strcmp(field->type, "const char *") == 0 &&
> > >                   ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
> > > -                  strstr(field->name, "path") != NULL))
> > > +                  strstr(field->name, "path") ||
> > > +                  strstr(field->name, "file") ||
> > > +                  strstr(field->name, "root") ||
> > > +                  strstr(field->name, "key") ||
> > > +                  strstr(field->name, "special") ||
> > > +                  strstr(field->name, "type") ||
> > > +                  strstr(field->name, "description")))
> > >                       arg->scnprintf = SCA_FILENAME;
> > >               else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
> > >                       arg->scnprintf = SCA_PTR;
> >
> > Humm?
> >
> > root@number:~# for field_name in file root key special type description ; do grep "field:.* $field_name\>" /sys/kernel/tracing/events/syscalls/sys_enter_*/format ; done
> >
> > /sys/kernel/tracing/events/syscalls/sys_enter_msgget/format:    field:key_t key;        offset:16;      size:8; signed:0;
> > /sys/kernel/tracing/events/syscalls/sys_enter_semget/format:    field:key_t key;        offset:16;      size:8; signed:0;
> > /sys/kernel/tracing/events/syscalls/sys_enter_shmget/format:    field:key_t key;        offset:16;      size:8; signed:0;
> > /sys/kernel/tracing/events/syscalls/sys_enter_quotactl/format:  field:const char * special;     offset:24;      size:8; signed:0;
> > /sys/kernel/tracing/events/syscalls/sys_enter_kcmp/format:      field:int type; offset:32;      size:8; signed:0;
> > /sys/kernel/tracing/events/syscalls/sys_enter_mount/format:     field:char * type;      offset:32;      size:8; signed:0;
> > /sys/kernel/tracing/events/syscalls/sys_enter_socket/format:    field:int type; offset:24;      size:8; signed:0;
> > /sys/kernel/tracing/events/syscalls/sys_enter_socketpair/format:        field:int type; offset:24;      size:8; signed:0;
> > /sys/kernel/tracing/events/syscalls/sys_enter_syslog/format:    field:int type; offset:16;      size:8; signed:0;
> > root@number:~#
> >
> > Skipping this one. Please ellaborate, what am I missing?
> 
> Hello, just some minor changes on your command, if I do:
> ```
> perf $ for field_name in file root key special type description ; do
> grep "field:.*char \* .*$field_name\>"
> /sys/kernel/tracing/events/syscalls/sys_enter_*/format ; done
> /sys/kernel/tracing/events/syscalls/sys_enter_swapoff/format:
> field:const char * specialfile;   offset:16;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_swapon/format:
> field:const char * specialfile;   offset:16;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_pivot_root/format:
> field:const char * new_root;     offset:16;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_fsconfig/format:
> field:const char * _key;  offset:32;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_quotactl/format:
> field:const char * special;       offset:24;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_add_key/format:
> field:const char * _type; offset:16;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_mount/format:
> field:char * type;        offset:32;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_request_key/format:field:const
> char * _type;        offset:16;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_add_key/format:
> field:const char * _description;  offset:24;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_request_key/format:field:const
> char * _description; offset:24;      size:8; signed:0;
> ```
> 
> They pop up.
> 
> Because it's strstr(), not strcmp(). Do you think we should use

Sure, that was my mistake, I was looking for those exact words, and its
being used as substrings.

> "strstr(field->name, "description") ||" or "strstr(field->name,
> "_description") ||"? Please let me know.

But I think using "key" as a a substring is way too generic to think
that a syscall arg with that in its name is necessarily a string.

We better look at the tracepoint _type_ instead since we have it in the
first place :-)

- Arnaldo
