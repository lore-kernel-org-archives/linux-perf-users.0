Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546822;
	b=Y9YdujgpNX13k53NhC0cciy54EADNlL0x38rQAvYccdJRKrI2h45fPLfk2lyJLf2fbz7
	 eImQHi5xqIZjMU5n2soMoTJE78K6FkhuA8Rb/mKuxHICt6Jg5ZwKsKk0RGg0kJEmyu4IT
	 LYpP88yJc1Kr89h7p1xuPRG4x6jMJKfkmr8GhBHT1HiLSNpspv5i3fsVEPFE/ymn3VUMQ
	 835VcRfmXcqIzNiA5YVJc4ab9NIiruUX7omVJ62Ca16DkKZuhOkd1sY5tb8Gpp2mXK58I
	 VcGsaVSSZguIQVmARTjCbk2QDicHlxXO4Bga2PchDw2qOyqOkspyE0DD80ogBHO1VmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546822;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Jlbugd7ArGg0S5aDGgTIS2sHzG8XtDdoajgT9zYidNM=;
	b=tbWHVpFAmPDRFf3DraBYdxdif0i97TD9Pql77w21YraslgyzmmWSa0T+5hhlBPAljCcA
	 jaEma/DqrX34zr44Ak/vNDSPSc6JTj8+EARv/O9vZxtUCojMWRKXtqXbJ6Lakdsn8wjC8
	 mwOExZxEWe3Y5gE1m+a4oYuXo+YIYHZL3hqq7k51Q01DiBIfWSl4enn6OgPV4zfzSDyAV
	 Cto06ohsyzeCAW6RHjEaow83En20zGsR/IMWjooShAz8SyAlTtPINpIhnuNHxR1US7nD5
	 BkOA8BRE1101zLzoRFuq4xWNgKq7y6F5lfC3vUczvtENqJc4Wcwhx8yKqBEhcOQCIdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkDmGosK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38148606A682;
	Tue, 24 Nov 2026 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkDmGosK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3926E1F000EE;
	Tue, 24 Nov 2026 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546821;
	bh=Jlbugd7ArGg0S5aDGgTIS2sHzG8XtDdoajgT9zYidNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bkDmGosKu464CtHjTp+ANIfhuUuthWUbBKhzmEPPq26c39zms7QWm2pPFHfh10+3r
	 q96lo2F3JaxAomZqzEddzpWZ2Xz5qBs70qwFs0wqwVqsDkAn+9HGRdGDubSosdg5ar
	 YuyoBdgww0xi3USzi/6sXpk9RR8FeFd45xN0LcNCC3n/QMzIBKn+NlAKTOayqgS2CD
	 sUylmykzBJ72R5GqxwKCccU1Ve9+dlUjzRtb4Dpsrc+uIToa7b2G6rveuvlhkjfxa3
	 IRAacWZVFFA1q11JnPZqZxJnYWDGUwuySvXTRGTxz0rWXCgKrxUGmdI+rIn0OfPg3E
	 JXqUMZcTdH7Xg==
Date: Tue, 24 Nov 2026 16:00:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Melo <arnaldo.melo@gmail.com>, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf build: Only enable context analysis with Clang 23
 or later
Message-ID: <awXewmptfc1za12c@phoenix2>
References: <20261123-james-perf-late-parse-attr-v1-1-cfebcd81a962@linaro.org>
 <CAP-5=fXuQWTt1F6BvKSXqgSkEtBQPKvKg6gmAe-ngyr4VGyGig@mail.gmail.com>
 <EC27692D-9692-4976-B7EA-4C3A91173CE3@gmail.com>
 <awSu48pUIh942Zm4@google.com>
 <46a896ba-cd45-4747-837d-50ea4b4dbed9@linaro.org>
 <0E9F372C-C100-41EC-B5B3-46FEDC813E01@gmail.com>
 <ceaea0f9-6f17-4626-bd55-fbc7366905ce@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceaea0f9-6f17-4626-bd55-fbc7366905ce@linaro.org>

On Tue, Nov 24, 2026 at 01:43:59PM +0000, James Clark wrote:
> On 24/11/2026 13:08, Arnaldo Melo wrote:
> > On November 24, 2026 8:24:37 AM GMT-03:00, James Clark <james.clark@linaro.org> wrote:
> > > Looks like __guarded_by() has also been around since at least clang 18, so that wasn't the issue. The problem is that it's not supported on struct _members_ specifically until clang 19.

> > > I sent another version that stubs it out for < 19 which works. The commit summary changed to "perf build: Stub out __guarded_by() on older Clang versions".

> > > The header diverges from the kernel one which isn't great, but I suppose that's better

> > Right, but you changed how check-headers.sh treats it to cope with the difference and I'll make sure that tools/perf/scripts/sync-headers.sh handles this case as well, namely if check-headers.sh detects drift, sync-headers.sh will update the tools copy while keeping the tools specific parts.
> > 
> > acme@number:~/git/perf-tools-next$ make -C tools/perf help | grep headers
> >    check-headers         - check which header copies are out of sync with the kernel
> >    sync-headers          - sync those header copies with the kernel, creating commits
> > acme@number:~/git/perf-tools-next$ tools/perf/scripts/sync-headers.sh --helpUsage: sync-headers.sh [OPTIONS]
> > 
> > Sync tools/ header copies with the kernel sources and create commits.
> > 
> > Options:
> >    -n, --dry-run       Show what would be done without making changes
> >    -N, --no-build      Skip the perf build verification step
> >    -C, --no-commit     Copy files but do not create git commits
> >    -f, --filter PAT    Only process headers matching PAT (substring match
> >                        against the kernel-side path)
> >    -F, --force         Sync also when both copies have content the other
> >                        lacks, after manual investigation; tools/ additions
> >                        dropped are recorded in the commit
> >    -o, --output DIR    Build output directory (default: /tmp/build/perf-tools-1000)
> >    -v, --verbose       Show more details
> >    -h, --help          Show this help
> > 
> > Environment:
> >    SIGN_OFF_NAME       Override git user.name for Signed-off-by
> >    SIGN_OFF_EMAIL      Override git user.email for Signed-off-by
> >    OUTPUT_DIR          Build output directory
> > 
> > Through make:
> >    SYNC_HEADERS_ARGS   Options to pass to this script, e.g.:
> >                        make -C tools/perf sync-headers SYNC_HEADERS_ARGS='-n'
> > 
> > The script:
> >    1. Runs 'make -C tools/perf check-headers' to find stale copies.
> >    2. For each stale header, identifies the kernel commits that changed it,
> >       including the merges that brought content of their own.
> >    3. Copies the kernel header into the tools/ tree, skipping it when only
> >       the tools/ copy changed (it is ahead) or when it carries intentional
> >       edits, and stopping for manual investigation when both sides have
> >       content the other lacks.
> >    4. For beauty headers, runs the relevant beauty script(s) before and
> >       after, showing new/changed string table entries.
> >    5. Builds perf and the other consumers of the header to verify nothing
> >       breaks.
> >    6. Creates a git commit per header (or group) with the standard commit
> >       message format.

> > acme@number:~/git/perf-tools-next$

> > I.e. the limitation in point number three, about intentional edits, needs to be lifted.
 
> Oh nice I hadn't noticed sync-headers.sh. What's the plan to support tools
> side edits? Something like exporting the kernel change as a patch and trying
> to apply it on top of the tools copy? Or I suppose you could do it the other
> way around and try to apply the tools diff on top of a new clean kernel
> copy.

I think the script should diff the current state, save that, copy the
new header, apply the patch to get the perf tools changes, then ask
opencode (or the coding agent used most frequently by the developer) to
check if what was done is sensible, then ask the developer to do a last
check and amends, sign off and commit.

Just like the following one, that I used to send the first fixes pull
req for this merge window to Linus, he accepted it straight away, so
brownie points to it (or to me + opencode + DeepSeek V4 (or was it Qween
Flash free? or... unsure :-))):

acme@number:~/git/perf-tools-next$ cat ../perf-dev-scripts/perf-upstream-tag.sh
#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
#
# Prepare a signed tag for a pull request to Linus from the perf
# tools tree.
#
# The merge window is derived from the latest tag in Linus' tree:
#
#   - vN.M-rcK: the release in progress is vN.M,
#   - vN.M:     no -rc1 for the next window was out yet, so the merge
#               window is vN.(M+1).
#
# If no perf-tools-for-vN.M tag exists yet for the current merge
# window, this is the merge window pull request and the tag will be
# perf-tools-for-vN.M-<seq>-<date>; otherwise it is a fixes pull
# request and the tag will be perf-tools-fixes-for-vN.M-<seq>-<date>,
# where vN.M is the release Linus is building.
#
# In two steps, the way git does commit messages:
#
#   1. Run without --continue. The programmatic parts happen here:
#      fetch, find the latest Linus tag, decide for vs fixes, compute
#      the tag name, get the commits not upstream via git cherry.
#      Their full commit texts then go, with the style rules and the
#      latest tag message as an example, to a coding agent (opencode
#      or claude, whichever is available and not disabled) to produce
#      the succinct grouped summary; without an agent it falls back
#      to one bullet per commit subject. The message is written to
#      $GIT_DIR/UPSTREAM_TAG_EDITMSG, like git's COMMIT_EDITMSG and
#      TAG_EDITMSG, for the maintainer to review and amend.
#   2. After editing, run with --continue: it checks that the branch
#      tip didn't move, that a GPG secret key is available, picks the
#      key used in the latest signed tag made by this maintainer
#      (overridable with -k), and creates the signed tag.
#
# Usage: perf-upstream-tag.sh [options]
#
# Options:
#   -r, --torvalds-remote R  Remote for Linus' tree (default: torvalds)
#   -b, --branch REF         Branch to be pulled (default: perf-tools)
#   -u, --push-remote R      Remote with the public tree, for the
#                            push/request-pull hints (default: acme,
#                            falling back to origin)
#   -k, --key KEYID          GPG key for signing (default: the key
#                            used in the latest signed tag made by
#                            the current maintainer)
#       --agent NAME         Coding agent for the summary: opencode,
#                            claude or none (default: auto-detect)
#       --continue           Create the signed tag from the message
#                            written by a previous run
#   -n, --dry-run            Print the plan, write nothing
#       --no-fetch           Do not fetch the Linus remote first
#   -h, --help               This help

set -euo pipefail

die() { echo "perf-upstream-tag: $*" >&2; exit 1; }

torvalds=torvalds
branch=perf-tools
push_remote=
agent=auto
key=
mode=draft
dry_run=0
do_fetch=1

while [ $# -gt 0 ]; do
	case "$1" in
	-r|--torvalds-remote) torvalds=$2; shift 2 ;;
	-b|--branch)          branch=$2; shift 2 ;;
	-u|--push-remote)     push_remote=$2; shift 2 ;;
	-k|--key)             key=$2; shift 2 ;;
	--agent)              agent=$2; shift 2 ;;
	--no-agent)           agent=none; shift ;;
	--continue)           mode='continue'; shift ;;
	-n|--dry-run)         dry_run=1; shift ;;
	--no-fetch)           do_fetch=0; shift ;;
	-h|--help)            sed -n '2,/^set /{ /^set /d; /^#!/d; s/^# \{0,1\}// p }' "$0"; exit 0 ;;
	*) die "unknown option: $1" ;;
	esac
done

gitdir=$(git rev-parse --absolute-git-dir) || die "not in a git tree"
editmsg="$gitdir/UPSTREAM_TAG_EDITMSG"
plan="$gitdir/UPSTREAM_TAG_PLAN"
[ -n "$push_remote" ] || push_remote=$(git remote | grep -x acme || echo origin)

if [ "$mode" = continue ]; then
	# Step 2: sign the message the maintainer left in UPSTREAM_TAG_EDITMSG.
	[ -f "$plan" ]    || die "no $plan, run without --continue first"
	[ -f "$editmsg" ] || die "no $editmsg, nothing to sign"
	# shellcheck source=/dev/null
	. "$plan"

	tip=$(git rev-parse --verify "$BRANCH_REF" 2>/dev/null) || \
		die "branch $BRANCH_REF is gone"
	[ "$tip" = "$SHA" ] || \
		die "branch tip moved from $SHA to $tip, rerun without --continue"
	git rev-parse -q --verify "refs/tags/$TAG" >/dev/null && \
		die "tag $TAG already exists"

	secret=$(gpg --list-secret-keys --with-colons 2>/dev/null | awk -F: '$1 == "sec" { print $5 }')
	[ -n "$secret" ] || die "no GPG secret key on $(hostname):
  the message is at $editmsg, the tag name in $plan.
  Run --continue on the machine holding your key, or
  pass --key when the key is in another GnuPG home"

	if [ -z "$key" ]; then
		# The key this maintainer used in the latest signed tag.
		email=$(git var GIT_COMMITTER_IDENT | sed -E 's/.*<([^>]*)>.*/\1/')
		for t in $(git for-each-ref --sort=-creatordate --format='%(refname:lstrip=2)' \
			   refs/tags/perf-tools-*); do
			te=$(git for-each-ref "refs/tags/$t" --format='%(taggeremail)' | tr -d '<>')
			case "$te" in *$email) ;; *) continue ;; esac
			line=$(git tag -v "$t" 2>&1 | sed -n 's/.*using [A-Z]* key \([0-9A-F]\{16,\}\).*/\1/p' | head -1 || true)
			if [ -n "$line" ]; then key=$line; break; fi
		done
	fi
	if [ -n "$key" ]; then
		echo "Signing $TAG with key $key"
		git tag -s -u "$key" -F "$editmsg" "$TAG" "$SHA"
	else
		echo "No previously signed tag by $email, using the default key"
		git tag -s -F "$editmsg" "$TAG" "$SHA"
	fi
	rm -f "$plan"
	echo
	echo "Push and send the pull request:"
	echo
	# shellcheck disable=SC2153  # PUSH_REMOTE comes from the sourced plan
	echo "  git push $PUSH_REMOTE $BRANCH_REF refs/tags/$TAG"
	echo "  git request-pull $LATEST_TAG <public tree url> $TAG"
	exit 0
fi

# Step 1: figure out what the pull request is and draft its message.
refname=
for r in "refs/heads/$branch" "refs/remotes/$branch"; do
	if git rev-parse -q --verify "$r" >/dev/null; then refname=$r; break; fi
done
[ -n "$refname" ] || die "branch '$branch' not found"
sha=$(git rev-parse --verify "$refname")

if [ "$do_fetch" = 1 ]; then
	git fetch --quiet --tags "$torvalds" || die "cannot fetch from '$torvalds', use --no-fetch"
fi

latest=$(git for-each-ref --sort=-creatordate --format='%(refname:lstrip=2)' "refs/tags/v*" |
	grep -E '^v[0-9]+\.[0-9]+(-rc[0-9]+)?$' | head -1 || true)
[ -n "$latest" ] || die "no vN.M(-rcK) tag found in the local tag list"

if [ "$latest" = "${latest%-rc*}" ]; then
	version=${latest#v}
	dev_version=$version
	window="$(( ${version%%.*} )).$(( ${version##*.} + 1 ))"
	rc=
else
	dev_version=${latest#v}; dev_version=${dev_version%-rc*}
	window=$dev_version
	rc=${latest##*-}
fi

upstream_ref=$(git for-each-ref --format='%(refname)' "refs/remotes/$torvalds/master")
[ -n "$upstream_ref" ] || die "no refs/remotes/$torvalds/master"

if [ -n "$(git for-each-ref --format='%(refname:lstrip=2)' "refs/tags/perf-tools-for-v${window}*")" ]; then
	kind=fixes
else
	kind=merge-window
fi

if [ "$kind" = fixes ]; then
	target=$dev_version
	pattern="perf-tools-fixes-for-v${target}"
	title="perf tools fixes for v${target}"
else
	target=$window
	pattern="perf-tools-for-v${window}"
	title="perf tools changes for v${window}"
fi
n=$(git for-each-ref --format='%(refname:lstrip=2)' "refs/tags/${pattern}*" |
    grep -c . || true)
seq=$((n + 1))
date=$(date +%F)
tag="${pattern}-${seq}-${date}"

git rev-parse -q --verify "refs/tags/$tag" >/dev/null && die "tag $tag already exists"

# Commits not upstream: cherry by patch-id, so commits already merged
# upstream by another route are skipped.
mapfile -t shas < <(git cherry -v "$upstream_ref" "$sha" | grep '^+' | cut -d' ' -f2 | tac)
count=${#shas[@]}
[ "$count" -gt 0 ] || die "$branch has nothing beyond $upstream_ref"

committer=$(git var GIT_COMMITTER_IDENT | sed -E 's/(<[^>]*>).*/\1/')

if [ "$dry_run" = 1 ]; then
	echo "dry run: tag $tag, $count commit(s), message not written"
	exit 0
fi

printf 'TAG=%q\nSHA=%q\nBRANCH_REF=%q\nLATEST_TAG=%q\nPUSH_REMOTE=%q\n' \
	"$tag" "$sha" "$refname" "$latest" "$push_remote" > "$plan"

# The last tag message of the same kind, minus the signature, is the
# style example handed to the agent.
example_sha=$(git for-each-ref --sort=-creatordate --format='%(objectname)' \
	"refs/tags/${pattern}-*" | head -1 || true)
if [ -z "$example_sha" ]; then
	example_sha=$(git for-each-ref --sort=-creatordate --format='%(objectname)' \
		'refs/tags/perf-tools-for-v*' | head -1 || true)
fi
if [ -n "$example_sha" ]; then
	example=$(git cat-file tag "$example_sha" 2>/dev/null |
		sed -n '/^$/,$p' | sed '1d;/-----BEGIN PGP/,$d')
else
	example=''
fi

commits=$(git show -s --format='%s%n%n%b' "${shas[@]}")

agent_cmd=
case "$agent" in
	auto)
		for a in opencode claude; do
			if command -v "$a" >/dev/null 2>&1; then agent_cmd=$a; break; fi
		done
		;;
	none) ;;
	*) if command -v "$agent" >/dev/null 2>&1; then agent_cmd=$agent; else
		   die "agent '$agent' not found"; fi ;;
esac

body=
if [ -n "$agent_cmd" ]; then
	# Quoted heredoc for the fixed text: commit messages contain $ and
	# backticks that must never be expanded.
	prompt=$(
		cat <<'RULES'
You are summarizing Linux perf commits for a maintainer's signed
pull request tag message. Output ONLY the bullet block: no title
line, no Signed-off-by, no fences, no preamble.

Rules:
- Bullet items start with "- ", continuation lines are indented
  two spaces, text wraps near 74 columns.
- AT MOST two lines per bullet, shorter than the example: name the
  area or subcommand, say what the change does, and stop.  No
  function names, no ioctl numbers, no error strings, no lists of
  affected machines or file paths beyond a few header names.
- One item per group, never one per commit: fold the header sync
  commits into a single item naming the headers; group the rest by
  area (symbol resolution, build, tests) or by subcommand (record,
  report, trace, top, kvm, jitdump, jevents, ...). New features
  first, then fixes, then cleanups.
- Succinct commentary on what the changes do, written from the full
  commit texts, not just the subjects. No diffstats, no review
  history, no walls of text.

Example, the latest tag message of this kind in this tree:

RULES
		printf '%s\n' "${example:-none available}"
		printf '\nCommits to summarize (%d commits):\n\n' "$count"
		printf '%s\n' "$commits"
	)
	if body=$(printf '%s' "$prompt" | timeout 600 "$agent_cmd" run 2>/dev/null || \
		 printf '%s' "$prompt" | timeout 600 "$agent_cmd" -p 2>/dev/null) && \
	   [ -n "$body" ]; then
		echo "Summary drafted by: $agent_cmd"
	else
		body=
		echo "agent '$agent_cmd' failed, falling back to subject bullets" >&2
	fi
fi

if [ -z "$body" ]; then
	body=$(printf '%s\n' "${shas[@]}" | xargs -rn1 git show -s --format='- %s')
fi

# The script adds the title and the trailer itself; drop them if the
# agent echoed them anyway, plus leading/trailing/double blank lines.
body=$(printf '%s\n' "$body" | awk -v title="$title" '
	/^Signed-off-by:/ { next }
	$0 == title       { next }
	NF == 0           { blank = 1; next }
	{ if (seen && blank) print ""; seen = 1; blank = 0; print }')

{
	printf '%s\n\n' "$title"
	printf '%s\n\n' "$body"
	printf 'Signed-off-by: %s\n' "$committer"
} > "$editmsg"

echo "Latest Linus tag:   $latest${rc:+ ($rc in the v${dev_version} cycle)}"
echo "Merge window:       v$window, tag for it: $( [ "$kind" = fixes ] && echo "perf-tools-for-v$window exists" || echo "none yet")"
echo "Tag to be created:  $tag -> $sha"
echo "Not upstream:       $count commit(s)"
echo
echo "Message written to: $editmsg"
echo "Review and amend it, then create the signed tag:"
echo
echo "  $0 --continue"
acme@number:~/git/perf-tools-next$

My plan is to have this in tools/perf/scripts/ so that whoever comes
after me and Namhyung, if this ends up being needed, don't have to go
thru such boring processes that were not automated due to lack of time
even being in my mind since forever as tech debt :-\ :-)

- Arnaldo
