Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794352468;
	b=PGQBPlLa/lvQWTzEXX64MEkMbsGu4sYqJY/rRpKxlz/01VRXia6JQ0ipFEso/NFc7D6B
	 1QYnChyFtyGLLZ9/V2sBz83rOWGelZttap4excNdF1ADEaku8bMdXk6pm9G9/JSN3lRu+
	 prg9NDiVhA1sFE9kN1tAuLyg0v/gJiLaG2hLCOJMkVJHeV8v4XcjvsMHj5r1dfJGQGzQB
	 LsG7RKAe+NXZKxbIQ46wTjdAZDtZ/uTgirzrw0yWuI/0S0mlTU3KVqLB5fQJ6UPLZNueV
	 fM7r4Sqi2K0TJDOikrKy1rTYMqUsNAPcXv3BC3N84Qb2GUfRB2I1AwhtWy8dbdbW1Wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QFIJPotnPl4zcCi4SEs2Thxfu9rvo/W9PjSXru65Fno=;
	b=nzYWkWnTbHXE2zVaHuzFz+YMLlZ4edkYsUYPy6VruFcaF8JXFASZbZbGArulPWFm49Fv
	 Oli8HOhdOiukt6mWXVSKsd5XRKBWMd7fFgSMzsSJdVtyWDRCJY0gq6Nb6k3wr3HjrmdNA
	 ZWMsebckEckmfA4KAFLlkIBHaSagHeCG83QxmK6JuA6sL5+vDEbXjNLnyj2FPit8pFIML
	 z1bEuMaGako+el4JP/SxxBbWG6jHCGxu9fZ45TRIusMD5eCqNU31YIJr6wx98Ow7olLIV
	 agtLN+E2siEaIEIIf7qDoalc1m84FYRWzeBw/OQRpBG9Er2Aw29Su8dn/f73bom3KOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kMeSCJ+M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25A606A326
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 23:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B25A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kMeSCJ+M
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-535f598d126so42051cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 15:14:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794352467; cv=none;
        d=google.com; s=arc-20260327;
        b=XHMIOPm1IEIytFvQ2s2+ExcXxYHyyjkNjKyeaQsUE9Hw24fbQvfzEcoMlFFT3aHdGG
         XMAC7oKzSChy4O+aBCtBpz3joq6SNC7DjL6QCJfkY315QDRQ4Vj12RncCxKNCAS3eHVz
         UNStIPEc90ZyTOACf9VUWLBafV724N91hSM0W5vO+KvYk4JL04RYz03rlGGIcH8I26ng
         92Hk9GZDmAz0sIUjhnci2RjwYdhT0Wbd+h1ZUDzotNcHt6YlC7JSU+oOVEDw4vC5J5LS
         zyvMy+2oII3Puy++oyMlBVWCNJB2OCj5OkIUz5FBHJd51j0CCH8+In+DmsHgi5C9O6Ns
         hA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QFIJPotnPl4zcCi4SEs2Thxfu9rvo/W9PjSXru65Fno=;
        fh=vYQm+a687T16YkvsngLFuJIRtNlReODa9fivTKMG/rc=;
        b=B55AwhZdOY/Y4SH/PFr5FnACPc5Tu3Rl0JbuIEI9T84P6z9zbuhT6dAthe9obA79ZK
         iX2Bw2Gxx8e8jr8tmi4R5vsp0JzSQHIqN3zb0FL6x573L+s2NoKSsj0fbAv02HXYtKiE
         o7MgZOm2QA/S/lx85LiJRitT40q/x+5gj7l1IWZf3bYPLcX9QQdFY77N9q2vY4lkMEmC
         mhHS0x3KmART2ckyCHO5Z/XssTh8w2pJTtiVxJIEsD8x+lkKknnZBDd+Gn8Q2whLdkYq
         kRydjBZXplhijv1U8+ZCA0eZ+NP6GE60jqKgZ07QfChxAkG0TMg35mcVheIyohvUiIpV
         c5ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794352467; x=1794957267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QFIJPotnPl4zcCi4SEs2Thxfu9rvo/W9PjSXru65Fno=;
        b=kMeSCJ+MOifXDk1cC0j8Q+/AMt23H13qBAeciTPnn/4pXHyFBDhupP5nFtIiqW7AvO
         fLL8DezCkK/U7QhS7rFLcGx0+EeW+Nx6ZWGJ14cUAZgwcnHUhvUQ4KZaDD0d8SallXkn
         yzIZP2oV1D4SrvM55Fs9sBLaXOuOzh5N2I+d0xgvJyW3c5aZze0Q9kykmBEc2Etuc9gz
         5J2k7jA8sg6sGgUBsrJUqwizvHbsO85TQr5d73jAhyRGezdSKAfaYvCbNowYZteXOL6w
         N7ajjlx3bJP7WGrPgWRFEqPgKG5RcvLVoYRNeOSxvLiAMf5Bz7bi0+YN5RlijFdUwDU5
         BbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794352467; x=1794957267;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QFIJPotnPl4zcCi4SEs2Thxfu9rvo/W9PjSXru65Fno=;
        b=H+uBdbX7UsIZxvKVB6j9A9hrJBPpnXSNBYKVlXo4xnPfOIW9dBt9QcpQgXemKlj+D2
         bFUds3Gn4eJRbhSFZArh3KoC/XBd0jcs5XASkc+8+FnVP8oTJaUlOfHVLjIqMJhOVDVl
         rGOGQwYKMuyvOv9ijB9fQbrhG4aONB9jJUI7JW08ycFjhUu1M60ljBhLOTO+2zwVFhSm
         xgFVdijijOjOh7wvFjT15R839TO9pP075vjqlckB38rif5WP/jj2MBIyAiC2jjTu6zIB
         Zm3Y08TmDGsWgq3tAZnLvlmdm/696RK+qhW5xJcMPMZwZMtKls2M4var79tRwSDnMD73
         CUng==
X-Forwarded-Encrypted: i=1; AL+hErEUOeboigItwthDZsS3k+mfIQLCqRckk+nCZzt/Zc6r8usujQ/Nwyh6FV5h4I2NCMBGUYp7YtkSAWNBnT8ilPKQ@vger.kernel.org
X-Gm-Message-State: APuU4Z9MFvTKoDQ0in7TUf/nzsCrkxGI6gxPt928gdn9HR62WETDasfs
	4HqWcTSlH/t+UnO8aNogBDjhC6qo/CThjXyC5ArZoywWfDMa5zaj5A4OOoLjYIHoZABQqSArEIC
	6zxf3p+apd5YRnYWn5FkPDmSTNCm3nPYsMHBzND/A
X-Gm-Gg: AYBFou3bivuyWdDCO8g/l1jyGnX1bFdbBTjmYrvlm7yOzYCRI2QA8uO6OcHsuggJBN4
	Q+hL34DyXzRIufRHtFi93OHSMyOAqAaO5h67IniYErGdI/MLOpNCV8LYF42ycmV/I5dRVQozN0S
	BZVJvXyOb94UNINpXbHK5OEZAOR8IQZ8qr7XtmlG6RgmjRU/bSU4antJadQHfMifj/1HSXVGNy3
	NUytSu09lzzwfnQAi/LeHJ8dVs09mrrpdF0pvf9e1wSI1l/FlqMi1i0LD0zlt08KpUBJaGTSnnV
	FFqHOkCsQF66Q1lExFb7rzalwhRRBOj4u+gKtP9U+Kw2A3bKBbpnaj1fkkaDAiDX+arol1uxEPW
	QLipP5zk0/YZR7mqfW3Ra7bHQ+WpNlyJffkWABlZkUEVbaxVialEFlIrlS64Sev7VbZo=
X-Received: by 2002:a05:622a:1f88:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-556a15e9f9bmr6139351cf.4.1794352465509; Tue, 10 Nov 2026
 15:14:25 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107044102.1506626-1-irogers@google.com> <avOhhIL1EExpcJBi@google.com>
In-Reply-To: <avOhhIL1EExpcJBi@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Nov 2026 15:14:14 -0800
X-Gm-Features: AclHuK9v8ZNyaAA2Ixe1LvY-E-TihixtplvYY9VkvlWYIDhpnTqSGK04R8mheG0
Message-ID: <CAP-5=fW4FLbm2pmUCC2Xohy4RFxnfoP9_eoOCLmUbeX9cabFnw@mail.gmail.com>
Subject: Re: [PATCH v11 00/20] tools/perf: Adopt kernel compiler-context-analysis.h
 annotations
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org, 
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, ndesaulniers@google.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Fri, Nov 06, 2026 at 08:40:41PM -0800, Ian Rogers wrote:
> > The perf tool previously added Clang thread-safety annotations in
> > tools/perf/util/mutex.h (GUARDED_BY, LOCKABLE, EXCLUSIVE_LOCK_FUNCTION,
> > UNLOCK_FUNCTION, etc.). Since then, the Linux kernel has adopted a
> > unified set of static context analysis macros and attributes in
> > include/linux/compiler-context-analysis.h (context_lock_struct,
> > __guarded_by, __acquires, __releases, __must_hold, etc.).
> >
> > This series makes tools/include/linux/compiler-context-analysis.h
> > functional by synchronizing it and the required compiler_types.h helper=
s
> > with the kernel headers, converts tools/perf from its custom mutex.h
> > macros to the kernel-style compiler-context-analysis.h annotations, and
> > expands context analysis coverage across comm, dso/dsos, thread/threads=
,
> > config, intel-tpebs, env, and maps. Along the way, separate preparatory
> > patches fix an unlocked __dsos__add() call and TOCTOU race in
> > __machine__addnew_vdso(), skip BPF and OOL DSOs in
> > dsos__find_kernel_dso(), ensure DSOs created in auxtrace, machine, and
> > symbol helpers belong to a dsos collection, avoid dropping
> > _dso__data_open_lock in dso__list_del() under REFCNT_CHECKING, switch
> > dso__data_open_lock and tpebs_mtx to DEFINE_MUTEX(), add a read-lock
> > fast path to dsos__findnew_id(), fix an unlocked read of
> > tpebs_reader_thread and double-close of tpebs_cmd.out in intel-tpebs,
> > avoid a potential read-to-write deadlock in maps__load_first(), and fix
> > map index lookup fallback and removal in maps.
> >
> > This series was developed and reviewed with assistance from an AI codin=
g
> > agent (Gemini 3.1 Pro) and reviewed with Sashiko.
>
> Is there any chance other tools than perf can be affected by this
> change?

So previously the annotations were in tools/perf/util in mutex.h
directory, the common context annotations didn't exist under tools/
and so this patch adds them. As such there are no existing users in
tools/ and no impact to other tools.
The minor kernel change avoids an unused parameter warning, but
shouldn't impact anything.

> How can I check this?  Does it require specific build flags?  Does it
> work with GCC as well?  Can we extend the build test to validate this
> automatically?

Building with clang/llvm is sufficient and already covered by the
build-test. I wanted this so the previous Abseil-style lock
annotations would be tested. The changes here rename the annotations
to match the kernel and then adds use of __guarded_by for better
correctness (and fixing the bugs this discovered on the way).

I'm working on a v12 to fix the Sashiko TPEBS finding.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > v11:
> >   - Rebase onto perf-tools-next.
> >   - Add Fixes tags to patches 7, 15, and 18.
> >   - Serialize tpebs_send_record_cmd() with teardown via
> >     tpebs_cmd_in_flight and tpebs_cmd_cond, check
> >     check_if_command_finished(&tpebs_cmd) under tpebs_mtx only when not
> >     stopping, guard evsel__tpebs_open() against a concurrent tpebs_stop=
()
> >     with a generation counter (tpebs_gen) and tpebs_stopping across
> >     closing the fds and finish_command(), and annotate tpebs_cmd,
> >     control_fd, ack_fd, tpebs_stopping, tpebs_cmd_in_flight, and
> >     tpebs_gen with __guarded_by(&tpebs_mtx) in patch 17.
> >
> > v10:
> >   - Split the maps__load_first() lock inversion fix (patch 18) from the
> >     maps index lookup and removal fixes (patch 19).
> >   - Fall back to the linear pointer scan in maps__by_address_index() an=
d
> >     maps__by_name_index() when bsearch() returns NULL, check
> >     map__start(prev) < map__start(new) in __maps__insert(), factor out
> >     __maps__remove_at() so maps__remove_maps() removes at index i
> >     directly without risking an infinite loop, guard against -1 index
> >     wraparound in maps__find_next_entry(), refresh sort invariants in
> >     maps__fixup_end() and machine__create_kernel_maps(), and add a unit
> >     test in tests/maps.c.
> >
> > v9:
> >   - Rebase onto perf-tools-next (resolving the conflict in
> >     tools/include/linux/compiler.h with ASSERT_STATIC_STORAGE() and
> >     converting the newly added dso__set_symsrc_filename() lock
> >     annotation in tools/perf/util/dso.h).
> >   - Move __must_hold_shared(&dsos->lock) on __dsos__find() from patch 1=
3
> >     into patch 7 where __dsos__find() is introduced so every commit in
> >     the series builds cleanly with -Wthread-safety.
> >
> > v8:
> >   - Set DSO_BINARY_TYPE__BPF_IMAGE for non-OOL ksymbol DSOs in
> >     machine__process_ksymbol_register() and skip
> >     DSO_BINARY_TYPE__BPF_PROG_INFO, DSO_BINARY_TYPE__BPF_IMAGE, and
> >     DSO_BINARY_TYPE__OOL in dsos__find_kernel_dso_cb() so that
> >     dsos__find_kernel_dso() does not match ksymbol DSOs in
> >     machine->dsos (patch 8).
> >   - Split the dsos__add() additions in auxtrace, machine, and symbol in=
to
> >     a standalone patch (patch 9) before "perf dso: Pass dso_data to
> >     close_data_fd() and dso__list_del()" (patch 10).
> >
> > v7:
> >   - Add newly created DSOs in machine__process_ksymbol_register() and
> >     dso__split_kallsyms() to machine->dsos so assert(dso__dsos(dso)) in
> >     dso__list_add() always holds.
> >   - Add __guarded_by(&config_mutex) to function-local static parser
> >     buffers in parse_value() and perf_parse_file().
> >   - Remove from maps_by_name before calling
> >     map__put(maps_by_address[address_idx]) in __maps__remove() so
> >     callers such as maps__remove_maps() that pass maps_by_address[i] as
> >     map do not use a freed handle in maps__by_name_index() under
> >     REFCNT_CHECKING.
> >
> > v6:
> >   - Rebase onto perf-tools-next.
> >
> > v5:
> >   - Hold machine->dsos.lock in write mode across machine->vdso_info
> >     initialization and temporary file creation in
> >     machine__findnew_vdso() and __machine__findnew_compat(), and
> >     annotate __machine__addnew_vdso() with
> >     __must_hold(&machine->dsos.lock).
> >   - Reset tpebs_cmd.pid =3D 0 and return early without setting
> >     t->started =3D true if start_command() fails in
> >     evsel__tpebs_start_perf_record().
> >
> > v4:
> >   - Place the DSO loaded in addr_filter__resolve_syms() into a dsos
> >     collection so dso__dsos(dso) is populated.
> >   - Join tpebs_reader_thread on error in evsel__tpebs_open(), document
> >     why tpebs_cmd.pid is cleared before pthread_join() in tpebs_stop(),
> >     and include <pthread.h> and <signal.h> in util/intel-tpebs.c.
> >   - Include <string.h> in util/maps.c.
> >
> > v3:
> >   - Rebase onto perf-tools-next (converting the newly added
> >     dso__find_binary_type() lock annotations in util/dso.c).
> >   - Separate bug fixes, DEFINE_MUTEX() cleanups, and improvements (vdso=
,
> >     dso_data, dso__data_open_lock, dsos__findnew_id, intel-tpebs,
> >     tpebs_mtx, maps) from the annotation patches.
> >   - Move AI coding assistant attribution to the cover letter and drop
> >     per-commit Assisted-by tags per linux-next
> >     Documentation/process/coding-assistants.rst.
> >   - Add Marco Elver's Reviewed-by to patch 1.
> >   - Define __diag_clang_23() and Clang ASM_INPUT_G/ASM_INPUT_RM/
> >     ASM_OUTPUT_RM overrides in tools/include/linux/compiler-gcc.h.
> >   - Probe for -Wthread-safety-pointer/-Wthread-safety-beta in
> >     Makefile.config.
> >   - Pass write_locked to __dsos__find().
> >   - Pass struct dso_data * to close_data_fd() and dso__list_del() to
> >     remove the REFCNT_CHECKING dso pointer from struct dso_data and
> >     avoid dropping dso__data_open_lock in dso__list_del(), and include
> >     <assert.h> in util/dso.c.
> >   - Re-validate DSO lookup under the write lock in dsos__findnew_id()
> >     via __dsos__findnew_id(), and handle NULL dso_id in
> >     dso__needs_improve_id(), __dso__improve_id(), and dso_id__cmp().
> >   - Reset tpebs_cmd.out =3D -1 if start_command() fails and include
> >     <stdint.h>, <stdlib.h>, <string.h>, and <unistd.h> in
> >     util/intel-tpebs.c.
> >   - Bounds-check the index in __maps__remove() (freeing maps_by_name if
> >     out of bounds).
> >
> > v2:
> >   - Use -c rather than -E when probing for
> >     -fexperimental-late-parse-attributes in Makefile.config to avoid
> >     -Werror,-Wunused-command-line-argument.
> >   - Acquire machine->dsos.lock in write mode across duplicate checking,
> >     dso__set_long_name(), and __dsos__add() in __machine__addnew_vdso()=
.
> >   - Avoid dropping dso__data_open_lock in dso__list_del() under
> >     REFCNT_CHECKING.
> >   - Pass tpebs_cmd.out directly to __sample_reader() and set
> >     tpebs_cmd.out =3D -1 in evsel__tpebs_open() to avoid a double-close=
 in
> >     tpebs_stop(), and clarify the config_set_mutex comment.
> >   - Drop maps__lock before calling map__load() in maps__load_first() to
> >     avoid a read-to-write self-deadlock when loading kernel maps insert=
s
> >     additional trampoline maps.
> >
> > Ian Rogers (20):
> >   compiler-context-analysis: Avoid unused parameter warning in
> >     _context_unsafe_alias()
> >   tools headers compiler: Synchronize compiler_types.h with the kernel
> >     sources
> >   tools headers: Synchronize linux/compiler-context-analysis.h with the
> >     kernel sources
> >   perf mutex: Use kernel style compiler-context-analysis.h annotations
> >   perf build: Enable additional Clang thread-safety flags
> >   perf comm: Add __guarded_by annotations to struct comm_strs
> >   perf vdso: Fix unlocked __dsos__add() and race in
> >     __machine__addnew_vdso()
> >   perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
> >   perf dsos: Ensure DSOs in auxtrace, machine, and symbol are in dsos
> >   perf dso: Pass dso_data to close_data_fd() and dso__list_del()
> >   perf dso: Use DEFINE_MUTEX for dso__data_open_lock
> >   perf dsos: Use read lock fast path in dsos__findnew_id()
> >   perf dso: Expand context analysis annotations
> >   perf thread: Expand context analysis annotations to threads and
> >     namespaces_lock
> >   perf intel-tpebs: Fix race in tpebs_stop() and tpebs_cmd.out fd
> >     handling
> >   perf intel-tpebs: Use DEFINE_MUTEX for tpebs_mtx
> >   perf config, intel-tpebs, env: Add __guarded_by and __must_hold
> >     annotations
> >   perf maps: Fix lock inversion in maps__load_first()
> >   perf maps: Fix map index lookup fallback and removal
> >   perf maps: Add context analysis annotations
> >
> >  include/linux/compiler-context-analysis.h     |   2 +-
> >  .../include/linux/compiler-context-analysis.h | 518 ++++++++++++++++--
> >  tools/include/linux/compiler-gcc.h            |  72 ++-
> >  tools/include/linux/compiler.h                |  50 +-
> >  tools/include/linux/compiler_types.h          | 206 ++++++-
> >  tools/perf/Makefile.config                    |   8 +-
> >  tools/perf/builtin-sched.c                    |  16 +-
> >  tools/perf/builtin-top.c                      |   4 +-
> >  tools/perf/check-headers.sh                   |   1 +
> >  tools/perf/tests/dso-data.c                   |   4 +
> >  tools/perf/tests/maps.c                       | 140 +++++
> >  tools/perf/util/annotate.c                    |   4 +-
> >  tools/perf/util/annotate.h                    |   8 +-
> >  tools/perf/util/auxtrace.c                    |  16 +-
> >  tools/perf/util/bpf-event.h                   |   5 +-
> >  tools/perf/util/comm.c                        |  10 +-
> >  tools/perf/util/config.c                      |  47 +-
> >  tools/perf/util/dso.c                         | 140 +++--
> >  tools/perf/util/dso.h                         |  17 +-
> >  tools/perf/util/dsos.c                        |  34 +-
> >  tools/perf/util/dsos.h                        |  12 +-
> >  tools/perf/util/env.c                         |   1 +
> >  tools/perf/util/env.h                         |  19 +-
> >  tools/perf/util/intel-tpebs.c                 | 206 ++++---
> >  tools/perf/util/libbfd.c                      |   4 +-
> >  tools/perf/util/machine.c                     |  34 +-
> >  tools/perf/util/maps.c                        | 216 +++++---
> >  tools/perf/util/mutex.c                       |   4 +-
> >  tools/perf/util/mutex.h                       |  90 +--
> >  tools/perf/util/rwsem.c                       |   8 +-
> >  tools/perf/util/rwsem.h                       |  10 +-
> >  tools/perf/util/symbol.c                      |   4 +
> >  tools/perf/util/thread.c                      |  10 +-
> >  tools/perf/util/thread.h                      |  30 +-
> >  tools/perf/util/threads.c                     |   4 +
> >  tools/perf/util/threads.h                     |   6 +-
> >  tools/perf/util/vdso.c                        |  53 +-
> >  37 files changed, 1477 insertions(+), 536 deletions(-)
> >
> >
> > base-commit: 13a8d580433a3b72b10be34f0e26787fe5659d3c
> > --
> > 2.56.0.455.g6c5a503b38-goog
> >
